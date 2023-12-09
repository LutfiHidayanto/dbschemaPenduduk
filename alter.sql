-- alter table menambah fk keluarga
ALTER TABLE [KELUARGA]
ADD CONSTRAINT [FK_keluarga_orang]
    FOREIGN KEY ([Id_kepala_keluarga]) REFERENCES [ORANG] ([Id_orang]);