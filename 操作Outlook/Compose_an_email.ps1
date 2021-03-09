$ol = New-Object -ComObject Outlook.Application
$mail = $ol.CreateItem(0)

$ComputerName=$env:COMPUTERNAME
$IPAddr = $IPAddr = [System.Net.Dns]::GetHostAddresses($env:COMPUTERNAME)  | ?{$_.AddressFamily -ne "InterNetworkV6"}
$UserLogonID = $env:USERNAME

#$mail.Recipients.Add("itsd@solex.com")
$mail.CC ="ITSD@SOLEX.COM"
$mail.HTMLBody = "
<p>你好，<span lang=EN-US><o:p></o:p></span></p>

<p>请协助一下。以下是我的计算机信息和问题描述<span lang=EN-US>:<o:p></o:p></span></p>

<table class=MsoTable15List3Accent1 border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid #5B9BD5 .5pt;
 mso-border-themecolor:accent1;mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
 mso-border-insideh:.5pt solid #D9D9D9;mso-border-insideh-themecolor:background1;
 mso-border-insideh-themeshade:217;mso-border-insidev:.5pt solid #D9D9D9;
 mso-border-insidev-themecolor:background1;mso-border-insidev-themeshade:217'>
 <tr style='mso-yfti-irow:-1;mso-yfti-firstrow:yes;mso-yfti-lastfirstrow:yes'>
      <td width=144 valign=top style='width:107.85pt;border-top:#5B9BD5;mso-border-top-themecolor:
      accent1;border-left:#5B9BD5;mso-border-left-themecolor:accent1;border-bottom:
      #D9D9D9;mso-border-bottom-themecolor:background1;mso-border-bottom-themeshade:
      217;border-right:#D9D9D9;mso-border-right-themecolor:background1;mso-border-right-themeshade:
      217;border-style:solid;border-width:1.0pt;mso-border-top-alt:#5B9BD5;
      mso-border-top-themecolor:accent1;mso-border-left-alt:#5B9BD5;mso-border-left-themecolor:
      accent1;mso-border-bottom-alt:#D9D9D9;mso-border-bottom-themecolor:background1;
      mso-border-bottom-themeshade:217;mso-border-right-alt:#D9D9D9;mso-border-right-themecolor:
      background1;mso-border-right-themeshade:217;mso-border-style-alt:solid;
      mso-border-width-alt:.5pt;background:#5B9BD5;mso-background-themecolor:accent1;
      padding:0cm 5.4pt 0cm 5.4pt'>
      <p class=MsoNormal style='mso-yfti-cnfc:517'><b style='mso-bidi-font-weight:
      normal'><span style='color:white;mso-themecolor:background1'>计算机名（自动收集）<span
      lang=EN-US style='mso-bidi-font-weight:bold'><o:p></o:p></span></span></b></p>
      </td>


      <td width=144 valign=top style='width:107.85pt;border-top:solid #5B9BD5 1.0pt;
      mso-border-top-themecolor:accent1;border-left:none;border-bottom:solid #D9D9D9 1.0pt;
      mso-border-bottom-themecolor:background1;mso-border-bottom-themeshade:217;
      border-right:solid #D9D9D9 1.0pt;mso-border-right-themecolor:background1;
      mso-border-right-themeshade:217;mso-border-left-alt:solid #D9D9D9 .5pt;
      mso-border-left-themecolor:background1;mso-border-left-themeshade:217;
      mso-border-alt:solid #D9D9D9 .5pt;mso-border-themecolor:background1;
      mso-border-themeshade:217;mso-border-top-alt:solid #5B9BD5 .5pt;mso-border-top-themecolor:
      accent1;background:#5B9BD5;mso-background-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt'>
      <p class=MsoNormal style='mso-yfti-cnfc:1'><b style='mso-bidi-font-weight:
      normal'><span lang=EN-US style='color:white;mso-themecolor:background1'>IP</span><span
      style='color:white;mso-themecolor:background1'>地址（自动收集）<span lang=EN-US
      style='mso-bidi-font-weight:bold'><o:p></o:p></span></span></b></p>
      </td>

      <td width=144 valign=top style='width:107.85pt;border-top:solid #5B9BD5 1.0pt;
      mso-border-top-themecolor:accent1;border-left:none;border-bottom:solid #D9D9D9 1.0pt;
      mso-border-bottom-themecolor:background1;mso-border-bottom-themeshade:217;
      border-right:solid #D9D9D9 1.0pt;mso-border-right-themecolor:background1;
      mso-border-right-themeshade:217;mso-border-left-alt:solid #D9D9D9 .5pt;
      mso-border-left-themecolor:background1;mso-border-left-themeshade:217;
      mso-border-alt:solid #D9D9D9 .5pt;mso-border-themecolor:background1;
      mso-border-themeshade:217;mso-border-top-alt:solid #5B9BD5 .5pt;mso-border-top-themecolor:
      accent1;background:#5B9BD5;mso-background-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt'>
      <p class=MsoNormal style='mso-yfti-cnfc:1'><b style='mso-bidi-font-weight:
      normal'><span lang=EN-US style='color:white;mso-themecolor:background1'></span><span
      style='color:white;mso-themecolor:background1'>用户登录名(自动收集）<span lang=EN-US
      style='mso-bidi-font-weight:bold'><o:p></o:p></span></span></b></p>
      </td>

      <td width=144 valign=top style='width:107.9pt;border-top:solid #5B9BD5 1.0pt;
      mso-border-top-themecolor:accent1;border-left:none;border-bottom:solid #D9D9D9 1.0pt;
      mso-border-bottom-themecolor:background1;mso-border-bottom-themeshade:217;
      border-right:solid #D9D9D9 1.0pt;mso-border-right-themecolor:background1;
      mso-border-right-themeshade:217;mso-border-left-alt:solid #D9D9D9 .5pt;
      mso-border-left-themecolor:background1;mso-border-left-themeshade:217;
      mso-border-alt:solid #D9D9D9 .5pt;mso-border-themecolor:background1;
      mso-border-themeshade:217;mso-border-top-alt:solid #5B9BD5 .5pt;mso-border-top-themecolor:
      accent1;background:#5B9BD5;mso-background-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt'>
      <p class=MsoNormal style='mso-yfti-cnfc:1'><b style='mso-bidi-font-weight:
      normal'><span style='color:white;mso-themecolor:background1'>联系电话<span
      lang=EN-US style='mso-bidi-font-weight:bold'><o:p></o:p></span></span></b></p>
      </td>

      <td width=513 valign=top style='width:384.75pt;border-top:solid #5B9BD5 1.0pt;
      mso-border-top-themecolor:accent1;border-left:none;border-bottom:solid #D9D9D9 1.0pt;
      mso-border-bottom-themecolor:background1;mso-border-bottom-themeshade:217;
      border-right:solid #5B9BD5 1.0pt;mso-border-right-themecolor:accent1;
      mso-border-left-alt:solid #D9D9D9 .5pt;mso-border-left-themecolor:background1;
      mso-border-left-themeshade:217;mso-border-top-alt:#5B9BD5;mso-border-top-themecolor:
      accent1;mso-border-left-alt:#D9D9D9;mso-border-left-themecolor:background1;
      mso-border-left-themeshade:217;mso-border-bottom-alt:#D9D9D9;mso-border-bottom-themecolor:
      background1;mso-border-bottom-themeshade:217;mso-border-right-alt:#5B9BD5;
      mso-border-right-themecolor:accent1;mso-border-style-alt:solid;mso-border-width-alt:
      .5pt;background:#5B9BD5;mso-background-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt'>
      <p class=MsoNormal style='mso-yfti-cnfc:1'><b style='mso-bidi-font-weight:
      normal'><span style='color:white;mso-themecolor:background1'>问题和需求描述<span
      lang=EN-US style='mso-bidi-font-weight:bold'><o:p></o:p></span></span></b></p>
      </td>
 </tr>

 <tr style='mso-yfti-irow:0;mso-yfti-lastrow:yes;height:41.15pt'>
          <td width=144 valign=top style='width:107.85pt;border-top:none;border-left:
          solid #5B9BD5 1.0pt;mso-border-left-themecolor:accent1;border-bottom:solid #5B9BD5 1.0pt;
          mso-border-bottom-themecolor:accent1;border-right:solid #D9D9D9 1.0pt;
          mso-border-right-themecolor:background1;mso-border-right-themeshade:217;
          mso-border-top-alt:solid #D9D9D9 .5pt;mso-border-top-themecolor:background1;
          mso-border-top-themeshade:217;mso-border-top-alt:#D9D9D9;mso-border-top-themecolor:
          background1;mso-border-top-themeshade:217;mso-border-left-alt:#5B9BD5;
          mso-border-left-themecolor:accent1;mso-border-bottom-alt:#5B9BD5;mso-border-bottom-themecolor:
          accent1;mso-border-right-alt:#D9D9D9;mso-border-right-themecolor:background1;
          mso-border-right-themeshade:217;mso-border-style-alt:solid;mso-border-width-alt:
          .5pt;background:white;mso-background-themecolor:background1;padding:0cm 5.4pt 0cm 5.4pt;
          height:41.15pt'>
          <p class=MsoNormal style='mso-yfti-cnfc:68'><b><span lang=EN-US>$ComputerName<o:p></o:p></span></b></p>
          </td>

          <td width=144 valign=top style='width:107.85pt;border-top:none;border-left:
          none;border-bottom:solid #5B9BD5 1.0pt;mso-border-bottom-themecolor:accent1;
          border-right:solid #D9D9D9 1.0pt;mso-border-right-themecolor:background1;
          mso-border-right-themeshade:217;mso-border-top-alt:solid #D9D9D9 .5pt;
          mso-border-top-themecolor:background1;mso-border-top-themeshade:217;
          mso-border-left-alt:solid #D9D9D9 .5pt;mso-border-left-themecolor:background1;
          mso-border-left-themeshade:217;mso-border-alt:solid #D9D9D9 .5pt;mso-border-themecolor:
          background1;mso-border-themeshade:217;mso-border-bottom-alt:solid #5B9BD5 .5pt;
          mso-border-bottom-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt;height:41.15pt'>
          <p class=MsoNormal style='mso-yfti-cnfc:64'><span lang=EN-US>$IPAddr<o:p></o:p></span></p>
          </td>

          <td width=144 valign=top style='width:107.85pt;border-top:none;border-left:
          none;border-bottom:solid #5B9BD5 1.0pt;mso-border-bottom-themecolor:accent1;
          border-right:solid #D9D9D9 1.0pt;mso-border-right-themecolor:background1;
          mso-border-right-themeshade:217;mso-border-top-alt:solid #D9D9D9 .5pt;
          mso-border-top-themecolor:background1;mso-border-top-themeshade:217;
          mso-border-left-alt:solid #D9D9D9 .5pt;mso-border-left-themecolor:background1;
          mso-border-left-themeshade:217;mso-border-alt:solid #D9D9D9 .5pt;mso-border-themecolor:
          background1;mso-border-themeshade:217;mso-border-bottom-alt:solid #5B9BD5 .5pt;
          mso-border-bottom-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt;height:41.15pt'>
          <p class=MsoNormal style='mso-yfti-cnfc:64'><span lang=EN-US>$UserLogonID<o:p></o:p></span></p>
          </td>

         <td width=144 valign=top style='width:107.9pt;border-top:none;border-left:
          none;border-bottom:solid #5B9BD5 1.0pt;mso-border-bottom-themecolor:accent1;
          border-right:solid #D9D9D9 1.0pt;mso-border-right-themecolor:background1;
          mso-border-right-themeshade:217;mso-border-top-alt:solid #D9D9D9 .5pt;
          mso-border-top-themecolor:background1;mso-border-top-themeshade:217;
          mso-border-left-alt:solid #D9D9D9 .5pt;mso-border-left-themecolor:background1;
          mso-border-left-themeshade:217;mso-border-alt:solid #D9D9D9 .5pt;mso-border-themecolor:
          background1;mso-border-themeshade:217;mso-border-bottom-alt:solid #5B9BD5 .5pt;
          mso-border-bottom-themecolor:accent1;padding:0cm 5.4pt 0cm 5.4pt;height:41.15pt'>
          <p class=MsoNormal style='mso-yfti-cnfc:64'><span lang=EN-US><o:p></o:p></span></p>
          </td>

          <td width=513 valign=top style='width:384.75pt;border-top:none;border-left:
          none;border-bottom:solid #5B9BD5 1.0pt;mso-border-bottom-themecolor:accent1;
          border-right:solid #5B9BD5 1.0pt;mso-border-right-themecolor:accent1;
          mso-border-top-alt:solid #D9D9D9 .5pt;mso-border-top-themecolor:background1;
          mso-border-top-themeshade:217;mso-border-left-alt:solid #D9D9D9 .5pt;
          mso-border-left-themecolor:background1;mso-border-left-themeshade:217;
          mso-border-top-alt:#D9D9D9;mso-border-top-themecolor:background1;mso-border-top-themeshade:
          217;mso-border-left-alt:#D9D9D9;mso-border-left-themecolor:background1;
          mso-border-left-themeshade:217;mso-border-bottom-alt:#5B9BD5;mso-border-bottom-themecolor:
          accent1;mso-border-right-alt:#5B9BD5;mso-border-right-themecolor:accent1;
          mso-border-style-alt:solid;mso-border-width-alt:.5pt;padding:0cm 5.4pt 0cm 5.4pt;
          height:41.15pt'>
          <p class=MsoNormal style='mso-yfti-cnfc:64'><span lang=EN-US><o:p></o:p></span></p>
          </td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
"


$mail.save()




$inspector = $mail.GetInspector
$inspector.Display()