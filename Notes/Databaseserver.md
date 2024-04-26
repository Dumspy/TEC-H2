Defaults
 - mssql ports = 1433, 1434
 - username = sa

'\*' = Required

MDF* = Rows
NDF = Extends Rows
- Mulighed for at udvide database på senere tidpunkt
LDF* = Logfile


```sql
CREATE TABLE [schema].[name](
    [name] [type] Default,
) on [filegroup]
```

```sql
use master
dbcc checkdb ('dbName') with no_infomsgs, all_errormsgs
```


# BCP

8bit/utf-8 -c -c 65001
16bit/utf-16 -w

bcp skoleDB.dbo.PostnrBy in 'path' -c -C 65001 -S server -T -t , -r \n
bcp skoleDB.dbo.PostnrBy out 'path' -w -S server -T -t , -r \n


# Bulk Insert
database.schema.table = skoleDB.dbo.postnrby


```sql
Bulk insert database.schema.table
from 'C:\Data\Databaser\Postnumre\PostNr.txt'
with
(
   codepage = '65001', -- 65001 = UTF8, ACP = auto
   batchsize = 250,
   datafiletype = 'char', -- widechar = 16bit, char = 8bit
   fieldterminator = ',',
   rowterminator = '\n',
   maxerrors = 50,
   tablock  )
```
