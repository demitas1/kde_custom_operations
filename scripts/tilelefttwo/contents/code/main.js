// デバッグ出力の制御
const DEBUG = false;

function debugLog(...args) {
    if (DEBUG) {
        print(...args);
    }
}

debugLog("Script loading...");

function tileLeftTwoThirds() {
    debugLog("tileLeftTwoThirds called");
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
    var targetWidth = Math.floor(area.width * 2/3);
    debugLog("Target width:", targetWidth);
    
    client.geometry = {
        x: area.x,
        y: area.y,
        width: targetWidth,
        height: area.height
    };
    
    debugLog("Window geometry updated to:", JSON.stringify(client.geometry));
}

registerShortcut("TileLeftTwoThirds", "Tile Left Two Thirds", "Meta+Shift+Left", function() {
    debugLog("Shortcut triggered");
    tileLeftTwoThirds();
});

debugLog("Script loaded successfully");
