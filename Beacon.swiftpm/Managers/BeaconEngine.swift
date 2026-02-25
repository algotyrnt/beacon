//
//  BeaconEngine.swift
//  Beacon
//
//  Created by Punjitha Bandara on 2026-02-12.
//

import Foundation
@preconcurrency import MultipeerConnectivity
import Combine
import UIKit

final class BeaconEngine: NSObject, ObservableObject, @unchecked Sendable {

    // MARK: - Public State
    @Published var connectedPeers: [MCPeerID] = []
    @Published var isRunning: Bool = false
    public let incomingData = PassthroughSubject<(Data, MCPeerID), Never>()

    // MARK: - Multipeer Core
    private let serviceType = "beacon-mesh"
    public let myPeerID: MCPeerID
    public let session: MCSession
    private let advertiser: MCNearbyServiceAdvertiser
    private let browser: MCNearbyServiceBrowser

    // MARK: - Init
    @MainActor
    override init() {
        let deviceName = UIDevice.current.name
        self.myPeerID = MCPeerID(displayName: deviceName)

        self.session = MCSession(
            peer: myPeerID,
            securityIdentity: nil,
            encryptionPreference: .required
        )

        self.advertiser = MCNearbyServiceAdvertiser(
            peer: myPeerID,
            discoveryInfo: nil,
            serviceType: serviceType
        )

        self.browser = MCNearbyServiceBrowser(
            peer: myPeerID,
            serviceType: serviceType
        )

        super.init()

        session.delegate = self
        advertiser.delegate = self
        browser.delegate = self
    }

    // MARK: - Start / Stop
    func start() {
        guard !isRunning else { return }
        
        advertiser.startAdvertisingPeer()
        browser.startBrowsingForPeers()
        isRunning = true
    }

    func stop() {
        guard isRunning else { return }
        
        advertiser.stopAdvertisingPeer()
        browser.stopBrowsingForPeers()
        session.disconnect()
        
        Task { @MainActor in
            self.connectedPeers.removeAll()
        }
        isRunning = false
    }

    // MARK: - Send Data
    func send(_ data: Data) {
        guard !session.connectedPeers.isEmpty else { return }

        do {
            try session.send(
                data,
                toPeers: session.connectedPeers,
                with: .reliable
            )
        } catch {
            print("Send error:", error.localizedDescription)
        }
    }
}

// MARK: - MCSessionDelegate
extension BeaconEngine: MCSessionDelegate {

    func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState
    ) {
        print("Peer \(peerID.displayName) changed state to \(state.rawValue)")
        
        Task { @MainActor in
            self.connectedPeers = session.connectedPeers
        }
    }

    func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID
    ) {
        incomingData.send((data, peerID))
    }

    func session(
        _ session: MCSession,
        didReceive stream: InputStream,
        withName streamName: String,
        fromPeer peerID: MCPeerID
    ) {}

    func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress
    ) {}

    func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?
    ) {}
}

// MARK: - Advertiser Delegate
extension BeaconEngine: MCNearbyServiceAdvertiserDelegate {

    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        invitationHandler(true, self.session)
    }
}

// MARK: - Browser Delegate
extension BeaconEngine: MCNearbyServiceBrowserDelegate {

    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String : String]?
    ) {
        browser.invitePeer(
            peerID,
            to: self.session,
            withContext: nil,
            timeout: 10
        )
    }

    func browser(
        _ browser: MCNearbyServiceBrowser,
        lostPeer peerID: MCPeerID
    ) {}
}
