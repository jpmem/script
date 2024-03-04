# �����̎w��
Param(
	# ���F�K���̖��O
	[Parameter(Mandatory=$True)]
	[string]$TargetApprovalRule
)

# WSUS �T�[�o�[�ɐڑ�
[void][reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$wsus=[Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer()

# ���F�K���̎擾
$Rule = $wsus.GetInstallApprovalRules() | where { $_.Name -eq $TargetApprovalRule}

# ���F�K���̗L����
$Rule.Enabled = $True
$Rule.Save()

# "�K���̎��s" ���s��
$Rule.ApplyRule()

# ���F�K���̖�����
$Rule.Enabled = $False
$Rule.Save()

