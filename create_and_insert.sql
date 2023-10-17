-- buat table akun 
CREATE table IF NOT EXISTS "akun" (
  "id" SERIAL PRIMARY key,
  "no_akun_rekening" varchar(255) NOT NULL,
  "id_nasabah" integer,
  "created_at" timestamp NOT NULL DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now()),
  "deleted_at" timestamp
);

--buat table nasabah  
CREATE TABLE  IF NOT EXISTS "nasabah" (
  "id"  SERIAL PRIMARY key,
  "nama" varchar(255) NOT NULL,
  "alamat" text NOT NULL,
  "tangal_lahir" date NOT NULL,
  "created_at" timestamp NOT null DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now()),
  "deleted_at" timestamp
);

--buat table transaksi 
CREATE TABLE  IF NOT EXISTS "transaksi" (
  "id" SERIAL PRIMARY key,
  "jumlah" integer NOT NULL,
  "status" varchar NOT NULL,
  "jenis" varchar NOT NULL,
  "id_akun" integer,
  "created_at" timestamp NOT NULL DEFAULT NOW(),
  "updated_at" timestamp DEFAULT (now()) ,
  "deleted_at" timestamp
);

--tambah relasi dari akun ke tabel transaksi
ALTER TABLE "transaksi" ADD FOREIGN KEY ("id_akun") REFERENCES "akun" ("id");

--tamba relasi nasabah ke table akun
ALTER TABLE "akun" ADD FOREIGN KEY ("id_nasabah") REFERENCES "nasabah" ("id");


--tambah index pada field nama di table nasabah 
CREATE INDEX idx_nasabah_nama ON nasabah (nama);

--insert data ke table nasabah 
insert into  nasabah (nama, alamat,tangal_lahir) values ('dian','gorontalo','2001-03-10');

-- insert  data ke table akun 
insert into  akun (no_akun_rekening,id_nasabah) values ('2131313123',1)

--insert data ke table transaksi 
insert into transaksi (jumlah, status,jenis,id_akun) values (4000,'pending','transfer',1);

--update nama nasabah

UPDATE nasabah SET nama = 'dian musfiroh' , updated_at  = now() WHERE id  = 1;

-- soft delete transaksi
UPDATE nasabah  SET  deleted_at  = now() WHERE id  = 1;

--hard delete data transaksi 
DELETE FROM transaksi  WHERE id = 1;

--hapus tabel transaksi
DROP TABLE IF EXISTS transaksi;

--hapus tabel transaksi
DROP TABLE IF EXISTS akun;

--hapus tabel transaksi
DROP TABLE IF EXISTS nasabah;

-- membuat stored procedure
CREATE OR REPLACE FUNCTION calculate_transaksi(id int)
RETURNS numeric AS $$
DECLARE
    total numeric;
    id int;
BEGIN


    select sum(jumlah) into total from transaksi where  id_akun  = calculate_transaksi.id;
   
    RETURN total;
END;
$$ LANGUAGE plpgsql;

--memenggil stored procedure
select calculate_transaksi(1);

--menghapus stored procedure
DROP FUNCTION calculate_transaksi(integer);









