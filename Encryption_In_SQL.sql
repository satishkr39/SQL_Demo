-- We must first create the master key. It must be created in the master database, 
USE Master;
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='InsertStrongPasswordHere';
GO

-- Create Certificate protected by master key. Once the master key is created 
-- along with the strong password (that you should remember or save in a secure location),
-- we will go ahead and create the actual certificate.
CREATE CERTIFICATE TDE_Cert
WITH 
SUBJECT='Database_Encryption';

-- use db encryption key. we must utilize our USE command to switch to the database 
--that we wish to encrypt. Then we create a connection or association between the 
--certificate that we just created and the actual database. Then we indicate the type 
--of encryption algorithm we are going to use. In this case it will be AES_256 encryption.

USE TestDB
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDE_Cert;

-- Enable Encryption
ALTER DATABASE TestDB
SET ENCRYPTION ON;
GO

-- Backup certificate. 
--It’s important to backup the certificate you created and store it in a secure location.
--If the server ever goes down and you need to restore it elsewhere, you will have to import
--the certificate to the server. In certain environments, the DR servers are already stood up
--and on warm/hot standby, so it’s a good idea to just preemptively import the saved 
-- certificate to these servers. 
use master
BACKUP CERTIFICATE TDE_Cert
TO FILE = 'C:\temp\TDE_Cert'
WITH PRIVATE KEY (file='C:\temp\TDE_CertKey.pvk',
ENCRYPTION BY PASSWORD='InsertStrongPasswordHere') 


-- Restoration of Certification on seconday server

-- create master key on secondary server
USE Master;
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='InsertStrongPasswordHere';
GO

--Once that is done, you must remember where you backed up the certificate and the 
-- encryption/decryption password.

USE MASTER
GO
CREATE CERTIFICATE TDECert
FROM FILE = 'C:\Temp\TDE_Cert'
WITH PRIVATE KEY (FILE = 'C:\TDECert_Key.pvk',
DECRYPTION BY PASSWORD = 'InsertStrongPasswordHere' );

-- Once the certificate is restored to the secondary server you may
-- restore a copy of the encrypted database.