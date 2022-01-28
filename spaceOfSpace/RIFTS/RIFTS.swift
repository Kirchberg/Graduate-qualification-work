//
//  RIFTS.swift
//  RIFTS
//
//  Created by Daniil Tchyorny on 19.04.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), img: UIImage(named: "APOD")!, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), img: UIImage(named: "APOD")!, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let userDefaults = UserDefaults(suiteName: "group.RiftsCache")
        let imageData=userDefaults?.value(forKey: "img") as? Data
        var image:UIImage?
        if let imageData=imageData{
            image = UIImage(data: imageData)
        } else {
            image=UIImage(named: "APOD")
        }
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,
                                    img: image!,
                                    configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let img: UIImage
    let configuration: ConfigurationIntent
}

struct RIFTSEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            GeometryReader{ geo in
                Image(uiImage: entry.img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width,
                           height: geo.size.height,
                           alignment: .center)
            }
        }
    }
}

@main
struct RIFTS: Widget {
    let kind: String = "RIFTS"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            RIFTSEntryView(entry: entry)
        }
        .configurationDisplayName("RIFTS Widget")
        .description("Shows random image from the space.")
    }
}

struct RIFTS_Previews: PreviewProvider {
    static var previews: some View {
        RIFTSEntryView(entry: SimpleEntry(date: Date(),img: UIImage(named: "APOD")!, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
