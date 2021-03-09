<#
 .Synopsis
  根据虚拟机的标记（Category)列出所有虚拟机.当前CAT-1是业务生产机，CAT-2是企业生产机，CAT-3是业务非生产机，CAT-4是企业非生产机
  需要VMware.PowerCli模块支持
 .Description

  根据虚拟机的标记（Category)列出所有虚拟机.当前CAT-1是业务生产机，CAT-2是企业生产机，CAT-3是业务非生产机，CAT-4是企业非生产机.
  需要VMware.PowerCli模块支持
 .Parameter Category
  CAT-1,CAT-2,CAT-3,CAT-4.

 .Parameter Username
  vCenter管理账号名.

 .Parameter Server
目标vCenter服务器名.


 .Example
 Get-VMGuestByCat -categroy CAT-4 -Useranem tixiang_lin   -Server Xmprvc67
#>

function Get-VMGuestbyCAT {

param (
    [Parameter(Mandatory=$True)]
    [string]$Category,

    [Parameter(Mandatory=$True)]
    [string]$Username,
    
    [Parameter(Mandatory=$True)]
    [string]$server
)

$cred= Get-Credential -UserName $username -Message "Enter your login credential for $server"
Connect-VIServer -Server $server -Credential $cred
Get-VM -tag $Category| Where { $_.PowerState -eq "PoweredOn" }
}

<#
 .Synopsis
  根据虚拟机的标记（Category)关机所有虚拟机.当前CAT-1是业务生产机，CAT-2是企业生产机，CAT-3是业务非生产机，CAT-4是企业非生产机。谨慎使用，只有在机房电力环境需要紧急关机情况下使用。
  需要VMware.PowerCli模块支持
 .Description

  根据虚拟机的标记（Category)列出所有虚拟机.当前CAT-1是业务生产机，CAT-2是企业生产机，CAT-3是业务非生产机，CAT-4是企业非生产机.
  需要VMware.PowerCli模块支持
 .Parameter Category
  CAT-1,CAT-2,CAT-3,CAT-4.

 .Parameter Username
  vCenter管理账号名.

 .Parameter Server
目标vCenter服务器名.


 .Example
 Shutdown-VMGuestByCat -categroy CAT-4 -Useranem tixiang_lin   -Server Xmprvc67
#>

function Shutdown-VMGuestbyCAT {

param (
    [Parameter(Mandatory=$True)]
    [string]$Category,

    [Parameter(Mandatory=$True)]
    [string]$Username,
    
    [Parameter(Mandatory=$True)]
    [string]$server
)


$cred= Get-Credential -UserName $username -Message "Enter your login credential for $server"
Connect-VIServer -Server $server -Credential $cred
$VMList=Get-VM -tag $Category| Where { $_.PowerState -eq "PoweredOn" }

Foreach ( $VM in $VMList ) { 

     # Checks if the name of the current VM is in the ExclusionList and skips if it is

       If ( $VMExclusionList -notcontains $VM.Name ) {

      

          # Retrieve the status of the VMware Tools 

          $ToolsStatus = ($VM | Get-View).Guest.ToolsStatus 

        

          # Check status of tools and if not installed then issue Stop to VM otherwise Shutdown VM 

          If ( $ToolsStatus -eq "toolsNotInstalled" ) { 

        

               Stop-VM $VM

        

          } Else {

    

               Shutdown-VMGuest $VM

          } 

     }

}
}