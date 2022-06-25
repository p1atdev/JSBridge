import * as lodash from "lodash"

export class Bridge {
    static sum(array) {
        // インジェクトされているか検証
        if (typeof sendMessage === "function") {
            // メッセージを送る
            sendMessage("Hello from JS!")
        }

        return lodash.sum(array)
    }
}
