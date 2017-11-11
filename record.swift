#!/usr/bin/env swift

import Foundation


let timePointsString = """
    Pressing power button
    Passcode screen appears
    Pressing enter to accept passcode
    Springboard appears
    Settings finishes launching
    Springboard appears
    Safari finishes launching
    The keyboard appears
    Springboard appears
    Siri begins listening
    Siri begins processing
    Siri displays the response
    Siri begins speaking the response
    Springboard appears
    Control Center appears
    Camera UI appears
    Camera image appears
    Camera button pressed
    Photo is taken
    New picture tapped
    New picture appears fullscreen
    Springboard appears
    Search appears
    Keyboard appears
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

func pad(_ str: String, to: Int) -> String {
    if str.count >= to {
        return str
    } else {
        return pad(str + " ", to: to)
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
    var times: [Time] = []
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
        let seconds = promptTime(timePoint + ": ")
        record.times.append(Record.Time(name: timePoint, seconds: seconds))
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    let data = try encoder.encode(record)
    try data.write(to: URL(fileURLWithPath: args[0]), options: [])
    print("Wrote \(args[0]).")
}

func read(_ args: [String]) throws {
    if args.count != 1 {
        print("usage: read [filename.json]")
        exit(1)
    }
    
    let data = try Data(contentsOf: URL(fileURLWithPath: args[0]))
    let decoder = JSONDecoder()
    let record = try decoder.decode(Record.self, from: data)
    
    print("Device: \(record.device) running iOS \(record.iOSVersion)")
    print("Recording date: \(record.date)")
    print("Video URL: \(record.videoURL)")
    if record.comment != "" {
        print("Comment: \(record.comment)")
    }
    
    for times in zip(record.times, record.times.dropFirst()) {
        let duration = String(times.1.seconds - times.0.seconds)
        print("\(pad(duration + "s", to: 10)) FROM \(times.0.name) TO \(times.1.name)")
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
