# Instructions:
# 1. Copy your certificate in Base64 format and paste it between the BEGIN and END lines in the $CertBase64 variable.
# 2. Add the script to the Hexnode script library
# 3. Execute it remotely from Hexnode MDM

$CertBase64 = @"
-----BEGIN CERTIFICATE-----
MIIC4jCCAcqgAwIBAgIQDm4PucFhTrke4VO0X5+eODANBgkqhkiG9w0BAQsFADAU
MRIwEAYDVQQDEwylbG9jYWxob3N0MB4XDTIzMTAwMTAwMDAwMFoXDTMzMTAwMTAw
...
Insert the Base64-encoded certificate here between the BEGIN and END lines.
...
-----END CERTIFICATE-----
"@

$StoreName = "Root"  # Change to the desired certificate store (e.g., Root, My, TrustedPeople, etc.)
$TempCertPath = [System.IO.Path]::Combine($env:TEMP, "cloudflare_zerotrust_root_cert.crt")

try {
    # Write Base64-encoded certificate to a temporary file
    Set-Content -Path $TempCertPath -Value $CertBase64 -Force
    Write-Host "Temporary certificate file created at: $TempCertPath" -ForegroundColor Green

    # Import the certificate to the specified certificate store
    Write-Host "Installing the certificate into the $StoreName store..." -ForegroundColor Yellow
    $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $Cert.Import($TempCertPath)

    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store $StoreName, "LocalMachine"
    $Store.Open("ReadWrite")
    $Store.Add($Cert)
    $Store.Close()

    Write-Host "Certificate installed successfully in the $StoreName store." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to install the certificate. $_" -ForegroundColor Red
} finally {
    # Clean up
    if (Test-Path $TempCertPath) {
        Remove-Item $TempCertPath -Force
        Write-Host "Cleaned up temporary certificate file." -ForegroundColor Cyan
    }
}