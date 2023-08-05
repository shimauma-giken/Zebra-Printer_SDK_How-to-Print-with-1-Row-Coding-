# ############################################################################
# プリンタのステータスが"Ready to Print"だったら印刷するバッチ処理
# ############################################################################
# ZSDK_API.jarと同じ階層で実行すること!!
# $ippAddr を送信先プリンタのIPに変更すること!!


$ipAddr = "192.168.4.54"
$statusReady = "Ready To Print"

$now = date

while ($var -le 4){
    $now = date
    $nowStr = $now.ToString("yyyy-MM-dd hh:mm:ss")

    $statusLatest = java -jar ZSDK_API.jar status  $ipAddr

    if ($statusLatest -eq $statusReady) {
        Write-Output ($nowStr + " > Info: Send print job because printer status is " + $statusLatest)
        java -jar ZSDK_API.jar send $ipAddr "^XA^FO50,50^A0N,50,50^FDHello Link-OS SDK!!^FS^XZ"
        Write-Output ($nowStr + " > Info: Print JOB has been sent") 
        $var++       
    }else{
        Write-Output ($nowStr + " > Warn: Waiting to send print job because printer status is " + $statusLatest)
    }
    Start-Sleep -Seconds 0.1
}
