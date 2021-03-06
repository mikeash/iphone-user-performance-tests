#!/usr/bin/env swift

import Foundation


let timePointsString = """
    Pressing power button
    Passcode/lock screen appears
    
    Pressing enter to accept passcode
    Springboard appears
    
    Settings tapped
    Settings finishes launching
    
    Home pressed in Settings
    Springboard appears
    
    Safari tapped
    Safari finishes launching
    
    Address bar tapped
    The keyboard appears
    
    Home pressed in Safari
    Springboard appears
    
    Siri button pressed
    Siri begins listening
    
    Siri begins processing
    Siri displays the response
    Siri begins speaking the response
    
    Home button pressed in Siri
    Springboard appears
    
    Control Center summoned
    Control Center appears
    
    Camera button tapped
    Camera UI appears
    Camera image appears
    
    Camera button pressed
    Photo is taken
    
    New picture tapped
    New picture appears fullscreen
    
    Home button pressed in Camera
    Springboard appears
    
    Swipe down on Springboard
    Search appears
    Keyboard appears
    
    Swipe up on Springboard
    Springboard appears
    """
let timePoints = timePointsString.components(separatedBy: "\n")

func prompt(_ str: String) -> String {
    print(str, terminator: "")
    guard let result = readLine() else {
        exit(0)
    }
    return result
}

func parseTime(_ str: String) -> Double? {
    let parts = str.components(separatedBy: ":")
    if parts.count == 1 {
        return Double(parts[0])
    } else if parts.count == 2 {
        let m = Double(parts[0])
        let s = Double(parts[1])
        if let m = m, let s = s {
            return m * 60 + s
        } else {
            return nil
        }
    } else {
        return nil
    }
}

func promptTime(_ str: String) -> Double {
    let input = prompt(str)
    if let time = parseTime(input) {
        return time
    } else {
        return promptTime("Could not parse time \"\(input)\". Please try again: ")
    }
}

func timeString(_ time: Double) -> String {
    let s = String(time)
    if s.hasSuffix(".0") {
        return String(s[..<s.index(s.endIndex, offsetBy: -2)])
    } else {
        return s
    }
}

struct Record: Codable {
    var videoURL: String = ""
    var device: String = ""
    var iOSVersion: String = ""
    var date: String = ""
    var comment: String = ""
    
    struct Time: Codable {
        var name: String
        var seconds: Double
    }
    var times: [Time?] = []
}

func make(_ args: [String]) throws {
    if args.count != 1 {
        print("usage: make [target-filename.json]")
        exit(1)
    }
    
    var record = Record()
    print("Welcome! Input your information.")
    print("================================")
    print("")
    
    record.videoURL = prompt("Video URL: ")
    record.device = prompt("Device: ")
    record.iOSVersion = prompt("iOS Version: ")
    record.date = prompt("Recording date (YYYY-MM-DD format): ")
    record.comment = prompt("Comment: ")
    
    print("Enter the times for each point in the video. Times may be entered in seconds (including fractions), or as minutes:seconds.")
    for timePoint in timePoints {
        if timePoint == "" {
            record.times.append(nil)
        } else {
            let seconds = promptTime(timePoint + ": ")
            record.times.append(Record.Time(name: timePoint, seconds: seconds))
        }
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    let data = try encoder.encode(record)
    try data.write(to: URL(fileURLWithPath: args[0]), options: [])
    print("Wrote \(args[0]).")
}

func read(_ args: [String]) throws {
    if args.count < 1 {
        print("usage: read <filename.json> [filenames.json...]")
        exit(1)
    }
    
    var first = true
    for arg in args {
        let data = try Data(contentsOf: URL(fileURLWithPath: arg))
        let decoder = JSONDecoder()
        let record = try decoder.decode(Record.self, from: data)
        
        if first {
            first = false
        } else {
            print("")
        }
        print("**Device**: \(record.device) running iOS \(record.iOSVersion)  ")
        print("**Recording date**: \(record.date)  ")
        print("**Video URL**: \(record.videoURL)  ")
        if record.comment != "" {
            print("**Comment**: \(record.comment)  ")
        }
        
        print("")
        print("| Description | Time Taken |")
        print("| :-- | --: |")
        
        for times in zip(record.times, record.times.dropFirst()) {
            if let first = times.0, let second = times.1 {
                let duration = timeString(second.seconds - first.seconds)
                print("""
                    | **From**: \(first.name)<br/>**To**: \(second.name) | \(duration)s |
                    """)
            }
        }
    }
}

let commandDispatch = [
    "make": make,
    "read": read,
]

let args = CommandLine.arguments.dropFirst()
guard let command = args.first, let f = commandDispatch[command] else {
    print("Specify one of: \(commandDispatch.keys.joined(separator: ", "))")
    exit(1)
}

do {
    try f(Array(args.dropFirst()))
} catch {
    print("Error: \(error)")
    exit(1)
}
