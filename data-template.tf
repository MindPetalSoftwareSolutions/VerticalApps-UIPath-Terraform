data "template_file" "init" {
  template = <<EOF
    <powershell>
    # Create a user account to interact with WinRM
    $Username = "terraform"
    $Password = "123456abcdef"
    $group = "Administrators"

    # Creating new local user
    & NET USER $Username $Password /add /y /expires:never
    # Adding local user to group
    & NET LOCALGROUP $group $Username /add
    # Ensuring password never expires
    & WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE

    # Enable WinRM Basic auth
    winrm set winrm/config/service/auth '@{Basic="true"}'
    # Create a self-signed cert
    $Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "parsec-aws"
    # Enable PSRemoting
    Enable-PSRemoting -SkipNetworkProfileCheck -Force
    # Disable HTTP Listener
    Get-ChildItem WSMan:\Localhost\listener | Where -Property Keys -eq "Transport=HTTP" | Remove-Item -Recurse
    # Enable HTTPS listener with certificate
    New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint -Force
    # Open firewall for HTTPS WinRM traffic
    New-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Name "Windows Remote Management (HTTPS-In)" -Profile Any -LocalPort 5986 -Protocol TCP
    </powershell>
    <persist>true</persist>
    EOF
}

/* data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["amazon", "self"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
} */

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["windows2016Server-1580136662"]
  }
}

data "aws_ami" "amazon_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}