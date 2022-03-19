import Foundation

enum StringResources {

    enum NextLaunch {

        enum NextLaunchViewController {
            static let isRecording = false
            static let testName = "NextLaunchViewController"
            static let shortMultipleCells = "ShortMultipleCells"
            static let normalMultipleCells = "NormalMultipleCells"
            static let longMultipleCells = "LongMultipleCells"
        }

        enum NextLaunchInfoCell {
            static let isRecording = false
            static let testName = "NextLaunchInfoCell"
            static let oneLineText = "OneLineText"
            static let longText = "LongText"
        }

        enum NextLaunchMissionCell {
            static let isRecording = false
            static let testName = "NextLaunchMissionCell"
            static let oneLineText = "OneLineText"
            static let longText = "LongText"
        }

        enum NextLaunchGalleryCell {
            static let isRecording = false
            static let testName = "NextLaunchGalleryCell"
            static let onePhoto = "OnePhoto"
            static let twoPhoto = "TwoPhoto"
            static let multiplePhoto = "MultiplePhoto"

            enum MockData {
                static let mockOnePhoto: [URL] = [
                    URL(string: "http://via.placeholder.com/142x114")!
                ]
                static let mockTwoPhoto: [URL] = [
                    URL(string: "http://via.placeholder.com/142x114")!,
                    URL(string: "http://via.placeholder.com/142x114")!
                ]
                static let mockMultiplePhoto: [URL] = [
                    URL(string: "http://via.placeholder.com/142x114")!,
                    URL(string: "http://via.placeholder.com/142x114")!,
                    URL(string: "http://via.placeholder.com/142x114")!,
                    URL(string: "http://via.placeholder.com/142x114")!
                ]
            }
        }

        enum NextLaunchLinksCell {
            static let isRecording = false
            static let testName = "NextLaunchLinksCell"
            static let oneLink = "OneLink"

            enum MockData {
                static let mockImageLink = URL(string: "http://via.placeholder.com/50x50")!
                static let mockSourceLink = URL(string: "https://www.google.com")!
            }
        }
    }

    enum News {
        enum NewsViewController {
            static let isRecording = false
            static let testName = "NewsViewController"
            static let testNewsViewControllerWithMultipleCells = "MultipleCells"
        }

        enum NewsCell {
            static let isRecording = false
            static let testName = "NewsCell"
            static let testNewsCellWithOneLineText = "OneLineText"
            static let testNewsCellWithTwoLineText = "TwoLineText"
            static let testNewsCellWithLongText = "LongText"
        }
    }

    enum Common {
        static let shortText = "Lorem ipsum dolor sit amet"
        static let normalText = "Integer tincidunt ultricies consectetur. Phasellus ut volutpat nisi."
        static let longText = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ac neque a erat varius hendrerit sit amet ut purus. Vestibulum pretium quis nisi venenatis eleifend. In at magna sit amet felis molestie hendrerit. Etiam consequat imperdiet ipsum ac laoreet. Etiam condimentum risus at ipsum efficitur mollis. Praesent vestibulum urna aliquam augue tempor malesuada. In sit amet finibus odio. Maecenas magna libero, convallis vitae turpis quis, congue rutrum quam. Duis malesuada bibendum nisi sit amet ultricies. Pellentesque egestas id metus at eleifend. Nunc finibus arcu velit, eget gravida leo sagittis vestibulum. Aliquam lectus arcu, ornare in orci et, bibendum interdum tellus. Pellentesque placerat pellentesque tellus, quis fermentum nibh dapibus id. Pellentesque eget turpis dignissim nibh ultrices consequat ut maximus tellus. Nulla pharetra, magna eu consequat pharetra, ex felis maximus neque, vel elementum sapien libero eu metus.
        """
    }
}
