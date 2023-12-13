-- imigran
select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "IMIGRAN" ON "ORANG"."Id_orang" = "IMIGRAN"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota_domisili" = "KOTA"."Id_kota"
JOIN "berkewarganegaraan" ON "IMIGRAN"."Id_orang" = "berkewarganegaraan"."Id_orang"
JOIN "NEGARA" ON "NEGARA"."Id_negara" = "berkewarganegaraan"."Id_negara"

-- kelahiran

SELECT 
    "ORANG"."Id_orang","Id_akta", "Nama_depan", "Nama_tengah", "Nama_belakang", "ORANG"."Id_KK", "KELUARGA"."Id_kepala_keluarga"
FROM "ORANG"
JOIN "KELAHIRAN" ON "ORANG"."Id_orang" = "KELAHIRAN"."Id_orang"
JOIN "ALAMAT" ON "KELAHIRAN"."Id_tempat" = "ALAMAT"."Id_alamat"
JOIN "KELUARGA" ON "KELUARGA"."Id_KK" = "ORANG"."Id_KK" 
    AND "KELUARGA"."Id_kepala_keluarga" = "ORANG"."Id_orang";


-- migrasi antar daerah

SELECT
	"MIGRASI"."Id_migrasi", "Nama_depan", "Nama_tengah", "Nama_belakang",
	"MIGRASI"."Status", "MIGRASI"."Tanggal", "MIGRASI_ANTAR_DAERAH"."alasan_migrasi", 
	"Kota_asal"."Nama_kota", "Kota_tujuan"."Nama_kota"
FROM "MIGRASI"
JOIN "MIGRASI_ANTAR_DAERAH" ON "MIGRASI"."Id_migrasi" = "MIGRASI_ANTAR_DAERAH"."id_migrasi"
JOIN "melakukan_migrasi" ON "MIGRASI"."Id_migrasi" = "melakukan_migrasi"."Id_migrasi"
JOIN "ORANG" ON "melakukan_migrasi"."id_orang" = "ORANG"."Id_orang"
JOIN "KOTA" AS "Kota_asal" ON "MIGRASI_ANTAR_DAERAH"."id_kota_asal" = "Kota_asal"."Id_kota" 
JOIN "KOTA" AS "Kota_tujuan" ON "MIGRASI_ANTAR_DAERAH"."id_kota_tujuan" = "Kota_tujuan"."Id_kota" 

-- imigrasi


SELECT
	"MIGRASI"."Id_migrasi", "Nama_depan", "Nama_tengah", "Nama_belakang",
	"MIGRASI"."Status", "MIGRASI"."Tanggal", "IMIGRASI"."Alasan_migrasi", 
	"NEGARA"."Nama_negara", "Kota_tujuan"."Nama_kota"
FROM "MIGRASI"
JOIN "IMIGRASI" ON "MIGRASI"."Id_migrasi" = "IMIGRASI"."Id_migrasi"
JOIN "melakukan_migrasi" ON "MIGRASI"."Id_migrasi" = "melakukan_migrasi"."Id_migrasi"
JOIN "ORANG" ON "melakukan_migrasi"."id_orang" = "ORANG"."Id_orang"
JOIN "KOTA" AS "Kota_tujuan" ON "IMIGRASI"."Id_kota" = "Kota_tujuan"."Id_kota" 
JOIN "NEGARA" ON "IMIGRASI"."Id_negara" = "NEGARA"."Id_negara"

-- pajak

S