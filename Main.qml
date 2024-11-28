pragma Strict
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ApplicationWindow {
    id: window

    width: 640
    height: 480
    visible: true
    title: qsTr("Gallery")

    color: "black"
    palette.windowText: "white"

    property int currentImageIndex: 0

    // Break points
    readonly property int tabletBreakPoint: 1000
    readonly property int mobileBreakPoint: 500

    readonly property bool isDesktopLayout: window.width > tabletBreakPoint
    readonly property bool isTabletLayout: window.width <= tabletBreakPoint && window.width >= mobileBreakPoint
    readonly property bool isMobileLayout: window.width <= mobileBreakPoint

    Component {
        id: thumbnailDelegate

        // A common Image delegate with a text which will be use in each example below
        Image {
            id: thumbnail

            required property int index

            source: Qt.resolvedUrl(`assets/image${index}.jpg`)
            asynchronous: true

            Layout.preferredWidth: 100
            Layout.preferredHeight: 100

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border {
                    color: "white"
                    width: window.currentImageIndex === thumbnail.index ? 2 : 0
                }
            }

            Label {
                anchors.centerIn: parent
                font.pixelSize: 30
                style: Text.Outline
                styleColor: "black"
                text: thumbnail.index
            }

            MouseArea {
                anchors.fill: parent
                onClicked: window.currentImageIndex = thumbnail.index
            }
        }
    }

    Flickable {
        id: flickable

        // Auto flick direction based on content size
        contentWidth: gridLayout.width
        contentHeight: gridLayout.height

        clip: true

        GridLayout {
            id: gridLayout

            columns: window.isDesktopLayout ? 2 : window.isTabletLayout ? 1 : -1
            rows: window.isMobileLayout ? 1 : -1

            Repeater {
                model: 10
                delegate: thumbnailDelegate
            }
        }
    }

    Image {
        id: previewImage

        // Visibility and size is going to be managed by LayoutProxies

        // In all cases, we will fill the width and height of the layout
        Layout.fillWidth: true
        Layout.fillHeight: true

        source: Qt.resolvedUrl(`assets/image${window.currentImageIndex}.jpg`)
        asynchronous: true
    }

    Label {
        id: sourceTitle
        text: qsTr("Source:")
        font.bold: true
    }
    Label {
        id: sourceValue
        text: previewImage.source
    }
    Label {
        id: widthTitle
        text: qsTr("Width:")
        font.bold: true
    }
    Label {
        id: widthValue
        text: previewImage.sourceSize.width
    }
    Label {
        id: heightTitle
        text: qsTr("Height:")
        font.bold: true
    }
    Label {
        id: heightValue
        text: previewImage.sourceSize.height
    }
    Label {
        id: paintedWidthTitle
        text: qsTr("PaintedWidth:")
        font.bold: true
    }
    Label {
        id: paintedWidthValue
        text: previewImage.paintedWidth
    }
    Label {
        id: paintedHeightTitle
        text: qsTr("PaintedHeight:")
        font.bold: true
    }
    Label {
        id: paintedHeightValue
        text: previewImage.paintedHeight
    }

    // Desktop Layout
    RowLayout {
        visible: window.isDesktopLayout

        anchors {
            fill: parent
            margins: 5
        }

        LayoutItemProxy {
            target: flickable

            Layout.fillHeight: true // Ensures that the Flickable fills the height of the RowLayout
            Layout.preferredWidth: gridLayout.width // Ensures the Flickable width matches the gridLayout's implicit (2 column) width
        }

        ColumnLayout {

            LayoutItemProxy {
                target: previewImage
            }

            RowLayout {
                Layout.minimumHeight: 40

                LayoutItemProxy {
                    target: sourceTitle
                }
                LayoutItemProxy {
                    target: sourceValue
                }
                LayoutItemProxy {
                    target: widthTitle
                }
                LayoutItemProxy {
                    target: widthValue
                }
                LayoutItemProxy {
                    target: heightTitle
                }
                LayoutItemProxy {
                    target: heightValue
                }
                LayoutItemProxy {
                    target: paintedWidthTitle
                }
                LayoutItemProxy {
                    target: paintedWidthValue
                }
                LayoutItemProxy {
                    target: paintedHeightTitle
                }
                LayoutItemProxy {
                    target: paintedHeightValue
                }
            }
        }
    }

    // Tablet Layout
    RowLayout {
        visible: window.isTabletLayout

        anchors {
            fill: parent
            margins: 5
        }

        LayoutItemProxy {
            target: flickable

            Layout.fillHeight: true // Ensures that the Flickable fills the height of the RowLayout
            Layout.preferredWidth: gridLayout.width // Ensures the Flickable width matches the gridLayout's implicit (2 column) width
        }

        LayoutItemProxy {
            target: previewImage
        }

        ColumnLayout {

            Layout.alignment: Qt.AlignTop
            Layout.minimumHeight: 40

            LayoutItemProxy {
                target: sourceTitle
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: sourceValue
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: widthTitle
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: widthValue
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: heightTitle
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: heightValue
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: paintedWidthTitle
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: paintedWidthValue
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: paintedHeightTitle
                Layout.leftMargin: 5
            }
            LayoutItemProxy {
                target: paintedHeightValue
                Layout.leftMargin: 5
            }
        }
    }

    // Mobile Layout
    ColumnLayout {
        visible: window.isMobileLayout

        anchors {
            fill: parent
            margins: 5
        }

        LayoutItemProxy {
            target: previewImage
        }

        GridLayout {
            columns: 4

            LayoutItemProxy {
                target: sourceTitle
            }
            LayoutItemProxy {
                target: sourceValue
                Layout.columnSpan: 3
            }
            LayoutItemProxy {
                target: widthTitle
            }
            LayoutItemProxy {
                target: widthValue
            }
            LayoutItemProxy {
                target: heightTitle
            }
            LayoutItemProxy {
                target: heightValue
            }
            LayoutItemProxy {
                target: paintedWidthTitle
            }
            LayoutItemProxy {
                target: paintedWidthValue
            }
            LayoutItemProxy {
                target: paintedHeightTitle
            }
            LayoutItemProxy {
                target: paintedHeightValue
            }
        }

        LayoutItemProxy
        {
            target: flickable

            Layout.fillWidth: true
            Layout.preferredHeight: gridLayout.height
        }
    }
}
