// デバッグ出力の制御
const DEBUG = false;

function debugLog(...args) {
    if (DEBUG) {
        print(...args);
    }
}

debugLog("Script loading...");

function tileRightOneThirds() {
    debugLog("tileRightOneThirds called");
    var client = workspace.activeClient;

    if (!client) {
        debugLog("No active client");
        return;
    }

    debugLog("Active client found");

    // 画面の取得
    var area = workspace.clientArea(KWin.PlacementArea, client.screen, client.desktop);
    debugLog("Screen area:", JSON.stringify(area));

    // 新しい位置とサイズを設定
    var targetX = area.x + Math.floor(area.width * 2/3);
    debugLog("Target x:", targetX);

    var targetWidth = Math.floor(area.width * 1/3);
    debugLog("Target width:", targetWidth);

    client.geometry = {
        x: targetX,
        y: area.y,
        width: targetWidth,
        height: area.height
    };

    debugLog("Window geometry updated to:", JSON.stringify(client.geometry));
}

registerShortcut("TileRightOneThirds", "Tile Right One Thirds", "Meta+Ctrl+Right", function() {
    debugLog("Shortcut triggered");
    tileRightOneThirds();
});

debugLog("Script loaded successfully");
