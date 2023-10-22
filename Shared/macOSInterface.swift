//
//  macOSInterface.swift
//  MacCast
//
//  Created by Saagar Jha on 10/9/23.
//

import CoreMedia
import Foundation

protocol macOSInterface {
	typealias M = macOSInterfaceMessages

	func _handshake(parameters: M.VisionOSHandshake.Request) async throws -> M.VisionOSHandshake.Reply
	func _windows(parameters: M.Windows.Request) async throws -> M.Windows.Reply
	func _windowPreview(parameters: M.WindowPreview.Request) async throws -> M.WindowPreview.Reply
	func _startCasting(parameters: M.StartCasting.Request) async throws -> M.StartCasting.Reply
	func _stopCasting(parameters: M.StopCasting.Request) async throws -> M.StopCasting.Reply
	func _startWatchingForChildWindows(parameters: M.StartWatchingForChildWindows.Request) async throws -> M.StartWatchingForChildWindows.Reply
	func _stopWatchingForChildWindows(parameters: M.StopWatchingForChildWindows.Request) async throws -> M.StopWatchingForChildWindows.Reply

}

struct Window: Codable, Identifiable {
	let windowID: UInt32
	let title: String?
	let app: String
	let frame: CGRect
	let windowLayer: Int

	var id: UInt32 {
		windowID
	}
}

enum macOSInterfaceMessages {
	struct VisionOSHandshake: Message {
		static let id = Messages.visionOSHandshake

		struct Request: Serializable, Codable {
			let version: Int
		}

		struct Reply: Serializable, Codable {
			let version: Int
		}
	}

	struct Windows: Message {
		static let id = Messages.windows

		typealias Request = SerializableVoid

		struct Reply: Serializable, Codable {
			let windows: [Window]
		}
	}

	struct WindowPreview: Message {
		static let id = Messages.windowPreview
		static let previewSize = CGSize(width: 600, height: 400)

		struct Request: Serializable, Codable {
			let windowID: Window.ID
		}

		typealias Reply = Frame?
	}

	struct StartCasting: Message {
		static let id = Messages.startCasting

		struct Request: Serializable, Codable {
			let windowID: Window.ID
		}

		typealias Reply = SerializableVoid
	}

	struct StopCasting: Message {
		static let id = Messages.stopCasting

		struct Request: Serializable, Codable {
			let windowID: Window.ID
		}

		typealias Reply = SerializableVoid
	}

	struct StartWatchingForChildWindows: Message {
		static let id = Messages.startWatchingForChildWindows

		struct Request: Serializable, Codable {
			let windowID: Window.ID
		}

		typealias Reply = SerializableVoid
	}

	struct StopWatchingForChildWindows: Message {
		static let id = Messages.stopWatchingForChildWindows

		struct Request: Serializable, Codable {
			let windowID: Window.ID
		}

		typealias Reply = SerializableVoid
	}
}