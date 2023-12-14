-- imigran
select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "IMIGRAN" ON "ORANG"."Id_orang" = "IMIGRAN"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota_domisili" = "KOTA"."Id_kota"
JOIN "berkewarganegaraan" ON "IMIGRAN"."Id_orang" = "berkewarganegaraan"."Id_orang"
JOIN "NEGARA" ON "NEGARA"."Id_negara" = "berkewarganegaraan"."Id_negara"


-- imigran ssms
select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "IMIGRAN" ON "ORANG"."Id_orang" = "IMIGRAN"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota" = "KOTA"."Id_kota"
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

SELECT 
    "ORANG"."Id_orang",
    "Id_akta",
    "ORANG"."Nama_depan",
    "ORANG"."Nama_tengah",
    "ORANG"."Nama_belakang",
    "KELAHIRAN"."Tanggal",
	"ALAMAT"."Id_kota",
    "ORANG"."Id_KK",
	CASE WHEN "AYAH"."Nama_depan" = "ORANG"."Nama_depan" THEN NULL ELSE "AYAH"."Nama_depan" END AS "Nama_depan_ayah",
    "IBU"."Nama_depan" AS "Nama_depan_ibu"
FROM "ORANG"
JOIN "KELAHIRAN" ON "ORANG"."Id_orang" = "KELAHIRAN"."Id_orang"
JOIN "ALAMAT" ON "KELAHIRAN"."Id_tempat" = "ALAMAT"."Id_alamat"
JOIN "KELUARGA" ON "KELUARGA"."Id_KK" = "ORANG"."Id_KK" 
LEFT JOIN "ORANG" AS "AYAH" ON "KELUARGA"."Id_kepala_keluarga" = "AYAH"."Id_orang"
LEFT JOIN "PERNIKAHAN" ON "PERNIKAHAN"."Id_pria" = "AYAH"."Id_orang"
LEFT JOIN "ORANG" AS "IBU" ON "IBU"."Id_orang" = "PERNIKAHAN"."id_wanita"
WHERE 
    ("AYAH"."Id_orang" != "ORANG"."Id_orang" OR "IBU"."Id_orang" != "ORANG"."Id_orang")
    OR ("AYAH"."Id_orang" IS NULL OR "IBU"."Id_orang" IS NULL)
ORDER BY "KELAHIRAN"."Id_akta" ASC


SELECT 
    "ORANG"."Id_orang",
    "Id_akta",
    "ORANG"."Nama_depan",
    "ORANG"."Nama_tengah",
    "ORANG"."Nama_belakang",
    "KELAHIRAN"."Tanggal",
	"TEMPATL"."Nama_kota",
    "ORANG"."Id_KK",
	CASE WHEN "AYAH"."Nama_depan" = "ORANG"."Nama_depan" THEN NULL ELSE "AYAH"."Nama_depan" END AS "Nama_depan_ayah",
    "IBU"."Nama_depan" AS "Nama_depan_ibu"
FROM "ORANG"
JOIN "KELAHIRAN" ON "ORANG"."Id_orang" = "KELAHIRAN"."Id_orang"
JOIN "ALAMAT" ON "KELAHIRAN"."Id_tempat" = "ALAMAT"."Id_alamat"
JOIN "KOTA" AS "TEMPATL" ON "TEMPATL"."Id_kota" = "ALAMAT"."Id_kota"
JOIN "KELUARGA" ON "KELUARGA"."Id_KK" = "ORANG"."Id_KK" 
LEFT JOIN "ORANG" AS "AYAH" ON "KELUARGA"."Id_kepala_keluarga" = "AYAH"."Id_orang"
LEFT JOIN "PERNIKAHAN" ON "PERNIKAHAN"."Id_pria" = "AYAH"."Id_orang"
LEFT JOIN "ORANG" AS "IBU" ON "IBU"."Id_orang" = "PERNIKAHAN"."id_wanita"
WHERE 
    ("AYAH"."Id_orang" != "ORANG"."Id_orang" OR "IBU"."Id_orang" != "ORANG"."Id_orang")
    OR ("AYAH"."Id_orang" IS NULL OR "IBU"."Id_orang" IS NULL)
ORDER BY "KELAHIRAN"."Id_akta" ASC


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

-- imigrasi sql
SELECT
	"MIGRASI"."Id_migrasi", "Nama_depan", "Nama_tengah", "Nama_belakang",
	"MIGRASI"."Status", "MIGRASI"."Tanggal", "IMIGRASI"."Alasan_imigrasi", 
	"NEGARA"."Nama_negara", "Kota_tujuan"."Nama_kota"
FROM "MIGRASI"
JOIN "IMIGRASI" ON "MIGRASI"."Id_migrasi" = "IMIGRASI"."Id_migrasi"
JOIN "melakukan_migrasi" ON "MIGRASI"."Id_migrasi" = "melakukan_migrasi"."Id_migrasi"
JOIN "ORANG" ON "melakukan_migrasi"."id_orang" = "ORANG"."Id_orang"
JOIN "KOTA" AS "Kota_tujuan" ON "IMIGRASI"."Id_kota" = "Kota_tujuan"."Id_kota" 
JOIN "NEGARA" ON "IMIGRASI"."Id_negara" = "NEGARA"."Id_negara"

-- pajak

SELECT
	"Id_npwp_tahun", "Jumlah_pajak_total", "Tahun", "Status", 
	"ORANG"."Nama_depan", "ORANG"."Nama_tengah", "ORANG"."Nama_belakang"
FROM "PAJAK"
JOIN "ORANG" ON "ORANG"."Id_orang" = "PAJAK"."Id_orang"

-- penduduk

select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "PENDUDUK" ON "ORANG"."Id_orang" = "PENDUDUK"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota_domisili" = "KOTA"."Id_kota"

-- penduduk sql

select *, "PEKERJAAN"."Nama_pekerjaan", "KOTA"."Nama_kota" from "ORANG"
JOIN "PENDUDUK" ON "ORANG"."Id_orang" = "PENDUDUK"."Id_orang"
JOIN "PEKERJAAN" ON "ORANG"."Id_pekerjaan" = "PEKERJAAN"."Id_pekerjaan"
JOIN "KOTA" ON "ORANG"."Id_kota" = "KOTA"."Id_kota"