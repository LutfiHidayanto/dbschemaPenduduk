CREATE NONCLUSTERED INDEX [idx_non_id_orang] 
ON [ORANG] ([Id_orang]);

CREATE CLUSTERED INDEX [idx_clustered_namaOrang] 
ON [ORANG] ([Nama_depan]);

CREATE NONCLUSTERED INDEX [idx_non_alamat] 
ON [ALAMAT] ([Id_alamat]);

-- clustered index yang lain sudah dibuat otomatis oleh sql server saat
-- define PRIMARY KEY

