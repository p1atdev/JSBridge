import * as lodash from "lodash"

export class Bridge {
    // 配列の和を取る
    static sum(array) {
        // インジェクトされているか検証
        if (typeof sendMessage === "function") {
            // メッセージを送る
            sendMessage("Hello from JS!")
        }

        return lodash.sum(array)
    }

    // 時間のかかる処理
    static async slowProcess() {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                resolve("Done!")
            }, 1000)
        })
    }
}
