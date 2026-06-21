//
//  IslandLiveCameras.swift
//  Island Now
//
//  各島のライブカメラURL（公式・配信元のページ）
//

import Foundation

enum IslandLiveCameras {
    static func cameras(for islandID: String) -> [LiveCamera] {
        switch islandID {
        case "ishigaki":
            return [
                LiveCamera(
                    title: "石垣港ライブカメラ（RBC）",
                    urlString: "https://www.youtube.com/watch?v=5jHCxMEGor0"
                ),
            ]
        case "taketomi":
            return [
                LiveCamera(
                    title: "八重山リアルタイム（竹富島周辺）",
                    urlString: "https://www.youtube.com/@YAEYAMALIVE"
                ),
            ]
        case "kuroshima":
            return [
                LiveCamera(
                    title: "八重山リアルタイム（黒島周辺）",
                    urlString: "https://www.youtube.com/@YAEYAMALIVE"
                ),
            ]
        case "hateruma":
            return [
                LiveCamera(
                    title: "八重山リアルタイム（波照間方面）",
                    urlString: "https://www.youtube.com/@YAEYAMALIVE"
                ),
            ]
        case "iriomote":
            return [
                LiveCamera(
                    title: "西表島ライブカメラ（ヤシガニNET）",
                    urlString: "https://www.youtube.com/@iriomote1956"
                ),
                LiveCamera(
                    title: "八重山リアルタイム（西表島周辺）",
                    urlString: "https://www.youtube.com/@YAEYAMALIVE"
                ),
            ]
        case "yonaguni":
            return [
                LiveCamera(
                    title: "八重山リアルタイム（ライブ配信）",
                    urlString: "https://www.youtube.com/@YAEYAMALIVE/live"
                ),
                LiveCamera(
                    title: "西埼灯台（海上保安庁・公式ページ）",
                    urlString: "https://www6.kaiho.mlit.go.jp/11kanku/ishigaki/irisaki_lt/livecamera/index.html"
                ),
            ]
        default:
            return []
        }
    }
}
