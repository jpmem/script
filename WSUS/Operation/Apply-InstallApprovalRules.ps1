# 引数の指定
Param(
	# 承認規則の名前
	[Parameter(Mandatory=$True)]
	[string]$TargetApprovalRule
)

# WSUS サーバーに接続
[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$wsus=[Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer()

# 承認規則の取得
$Rule = $wsus.GetInstallApprovalRules() | where { $_.Name -eq $TargetApprovalRule}

# 承認規則の有効化
$Rule.Enabled = $True
$Rule.Save()

# "規則の実行" を行う
$Rule.ApplyRule()

# 承認規則の無効化
$Rule.Enabled = $False
$Rule.Save()

