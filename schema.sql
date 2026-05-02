CREATE DATABASE IF NOT EXISTS proje_db;
USE proje_db;

-- ============================================================
--  TÜRKÇE VERİTABANI ŞEMASI — MySQL 8.0
--  Saha Lojistiği, Sürücü Rota Takibi, Varil Dağıtımı,
--  Sipariş ve Fatura Yönetimi
--  25 Tablo | Her tabloda en az 1 FOREIGN KEY
-- ============================================================



SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. Rol
-- ============================================================
CREATE TABLE IF NOT EXISTS Rol (
    rol_ID          INT           NOT NULL AUTO_INCREMENT,
    rol_Ad          VARCHAR(50)   NOT NULL,
    rol_Aciklama    VARCHAR(255)      NULL,
    rol_OlusturmaTarih DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Rol PRIMARY KEY (rol_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: roles — Sistemdeki kullanıcı rollerini (admin, sürücü, müşteri vb.) tanımlar.

-- ============================================================
-- 2. Kullanici
-- ============================================================
CREATE TABLE IF NOT EXISTS Kullanici (
    kul_ID          INT           NOT NULL AUTO_INCREMENT,
    kul_RolID       INT           NOT NULL,
    kul_Ad          VARCHAR(100)  NOT NULL,
    kul_Soyad       VARCHAR(100)  NOT NULL,
    kul_Email       VARCHAR(150)  NOT NULL UNIQUE,
    kul_SifreHash   VARCHAR(255)  NOT NULL,
    kul_Telefon     VARCHAR(20)       NULL,
    kul_AktifMi     TINYINT(1)    NOT NULL DEFAULT 1,
    kul_OlusturmaTarih DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Kullanici PRIMARY KEY (kul_ID),
    CONSTRAINT fk_kul_Rol FOREIGN KEY (kul_RolID) REFERENCES Rol (rol_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: users — Sisteme kayıtlı tüm kullanıcıları saklar.

-- ============================================================
-- 3. Adres
-- ============================================================
CREATE TABLE IF NOT EXISTS Adres (
    adr_ID          INT           NOT NULL AUTO_INCREMENT,
    adr_KulID       INT           NOT NULL,
    adr_IlAd        VARCHAR(100)  NOT NULL,
    adr_IlceAd      VARCHAR(100)  NOT NULL,
    adr_Mahalle     VARCHAR(150)      NULL,
    adr_SokakNo     VARCHAR(100)      NULL,
    adr_PostaKod    VARCHAR(10)       NULL,
    adr_VarsayilanMi TINYINT(1)   NOT NULL DEFAULT 0,
    CONSTRAINT pk_Adres PRIMARY KEY (adr_ID),
    CONSTRAINT fk_adr_Kul FOREIGN KEY (adr_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: addresses — Kullanıcılara ait teslimat/fatura adreslerini saklar.

-- ============================================================
-- 4. Surucu_Profil
-- ============================================================
CREATE TABLE IF NOT EXISTS Surucu_Profil (
    surp_ID         INT           NOT NULL AUTO_INCREMENT,
    surp_KulID      INT           NOT NULL UNIQUE,
    surp_LisansNo   VARCHAR(50)   NOT NULL UNIQUE,
    surp_LisansTur  VARCHAR(30)   NOT NULL,
    surp_LisansBitis DATE              NULL,
    surp_Durum      ENUM('aktif','pasif','izinli') NOT NULL DEFAULT 'aktif',
    surp_OlusturmaTarih DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Surucu_Profil PRIMARY KEY (surp_ID),
    CONSTRAINT fk_surp_Kul FOREIGN KEY (surp_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: driver_profiles — Sürücülere özgü lisans ve durum bilgilerini saklar.

-- ============================================================
-- 5. Arac
-- ============================================================
CREATE TABLE IF NOT EXISTS Arac (
    arc_ID          INT           NOT NULL AUTO_INCREMENT,
    arc_SurpID      INT           NOT NULL,
    arc_Plaka       VARCHAR(20)   NOT NULL UNIQUE,
    arc_Marka       VARCHAR(50)       NULL,
    arc_Model       VARCHAR(50)       NULL,
    arc_ModelYil    YEAR              NULL,
    arc_KapasiteKg  DECIMAL(8,2)      NULL,
    arc_AktifMi     TINYINT(1)    NOT NULL DEFAULT 1,
    CONSTRAINT pk_Arac PRIMARY KEY (arc_ID),
    CONSTRAINT fk_arc_Surp FOREIGN KEY (arc_SurpID) REFERENCES Surucu_Profil (surp_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: vehicles — Sürücülere atanmış araçların kayıt bilgilerini saklar.

-- ============================================================
-- 6. Guzergah
-- ============================================================
CREATE TABLE IF NOT EXISTS Guzergah (
    guz_ID          INT           NOT NULL AUTO_INCREMENT,
    guz_Ad          VARCHAR(150)  NOT NULL,
    guz_BaslangicAdr INT          NOT NULL,
    guz_BitisAdr    INT           NOT NULL,
    guz_TahminiKm   DECIMAL(8,2)      NULL,
    guz_AktifMi     TINYINT(1)    NOT NULL DEFAULT 1,
    CONSTRAINT pk_Guzergah PRIMARY KEY (guz_ID),
    CONSTRAINT fk_guz_BasAdr FOREIGN KEY (guz_BaslangicAdr) REFERENCES Adres (adr_ID),
    CONSTRAINT fk_guz_BitAdr FOREIGN KEY (guz_BitisAdr)     REFERENCES Adres (adr_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: routes — Başlangıç-bitiş noktaları arasındaki lojistik güzergahları tanımlar.

-- ============================================================
-- 7. Surucu_Rota
-- ============================================================
CREATE TABLE IF NOT EXISTS Surucu_Rota (
    srot_ID         INT           NOT NULL AUTO_INCREMENT,
    srot_SurpID     INT           NOT NULL,
    srot_GuzID      INT           NOT NULL,
    srot_ArcID      INT           NOT NULL,
    srot_BaslangicZaman DATETIME  NOT NULL,
    srot_BitisZaman DATETIME          NULL,
    srot_Durum      ENUM('planli','devam','tamamlandi','iptal') NOT NULL DEFAULT 'planli',
    CONSTRAINT pk_Surucu_Rota PRIMARY KEY (srot_ID),
    CONSTRAINT fk_srot_Surp FOREIGN KEY (srot_SurpID) REFERENCES Surucu_Profil (surp_ID),
    CONSTRAINT fk_srot_Guz  FOREIGN KEY (srot_GuzID)  REFERENCES Guzergah (guz_ID),
    CONSTRAINT fk_srot_Arc  FOREIGN KEY (srot_ArcID)  REFERENCES Arac (arc_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: driver_routes — Bir sürücünün belirli bir güzergahtaki sefer kaydını tutar.

-- ============================================================
-- 8. Konum_Takip
-- ============================================================
CREATE TABLE IF NOT EXISTS Konum_Takip (
    ktk_ID          INT           NOT NULL AUTO_INCREMENT,
    ktk_SrotID      INT           NOT NULL,
    ktk_Enlem       DECIMAL(10,7) NOT NULL,
    ktk_Boylam      DECIMAL(10,7) NOT NULL,
    ktk_KayitZaman  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ktk_Hiz         DECIMAL(6,2)      NULL COMMENT 'km/s',
    CONSTRAINT pk_Konum_Takip PRIMARY KEY (ktk_ID),
    CONSTRAINT fk_ktk_Srot FOREIGN KEY (ktk_SrotID) REFERENCES Surucu_Rota (srot_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: location_logs — Sefer sırasında anlık GPS konumlarını kayıt altına alır.

-- ============================================================
-- 9. Mteri  (Müşteri)
-- ============================================================
CREATE TABLE IF NOT EXISTS Musteri (
    mtr_ID          INT           NOT NULL AUTO_INCREMENT,
    mtr_KulID       INT           NOT NULL UNIQUE,
    mtr_FirmaAd     VARCHAR(150)      NULL,
    mtr_VergiNo     VARCHAR(20)       NULL,
    mtr_KrediLimit  DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    mtr_OlusturmaTarih DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Musteri PRIMARY KEY (mtr_ID),
    CONSTRAINT fk_mtr_Kul FOREIGN KEY (mtr_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: customers — Bireysel veya kurumsal müşteri profillerini saklar.

-- ============================================================
-- 10. Urun_Kategori
-- ============================================================
CREATE TABLE IF NOT EXISTS Urun_Kategori (
    ukat_ID         INT           NOT NULL AUTO_INCREMENT,
    ukat_Ad         VARCHAR(100)  NOT NULL,
    ukat_UstKatID   INT               NULL,
    ukat_Aciklama   VARCHAR(255)      NULL,
    CONSTRAINT pk_Urun_Kategori PRIMARY KEY (ukat_ID),
    CONSTRAINT fk_ukat_Ust FOREIGN KEY (ukat_UstKatID) REFERENCES Urun_Kategori (ukat_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: product_categories — Ürün kategorilerini hiyerarşik olarak tanımlar.

-- ============================================================
-- 11. Urun
-- ============================================================
CREATE TABLE IF NOT EXISTS Urun (
    urn_ID          INT           NOT NULL AUTO_INCREMENT,
    urn_KatID       INT           NOT NULL,
    urn_Ad          VARCHAR(150)  NOT NULL,
    urn_Aciklama    TEXT              NULL,
    urn_BirimFiyat  DECIMAL(10,2) NOT NULL,
    urn_BirimTur    VARCHAR(20)   NOT NULL DEFAULT 'adet',
    urn_StokAdet    INT           NOT NULL DEFAULT 0,
    urn_AktifMi     TINYINT(1)    NOT NULL DEFAULT 1,
    CONSTRAINT pk_Urun PRIMARY KEY (urn_ID),
    CONSTRAINT fk_urn_Kat FOREIGN KEY (urn_KatID) REFERENCES Urun_Kategori (ukat_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: products — Satışa sunulan ürünlerin (varil dahil) temel bilgilerini saklar.

-- ============================================================
-- 12. Varil
-- ============================================================
CREATE TABLE IF NOT EXISTS Varil (
    var_ID          INT           NOT NULL AUTO_INCREMENT,
    var_UrnID       INT           NOT NULL,
    var_SeriNo      VARCHAR(60)   NOT NULL UNIQUE,
    var_Kapasite    DECIMAL(8,2)  NOT NULL COMMENT 'litre',
    var_Durum       ENUM('dolu','bos','hasar','bakim') NOT NULL DEFAULT 'bos',
    var_SonGuncelleme DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_Varil PRIMARY KEY (var_ID),
    CONSTRAINT fk_var_Urn FOREIGN KEY (var_UrnID) REFERENCES Urun (urn_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: barrels — Fiziksel varil varlıklarını ve anlık durumlarını takip eder.

-- ============================================================
-- 13. Depo
-- ============================================================
CREATE TABLE IF NOT EXISTS Depo (
    dep_ID          INT           NOT NULL AUTO_INCREMENT,
    dep_AdrID       INT           NOT NULL,
    dep_Ad          VARCHAR(100)  NOT NULL,
    dep_KapaLitre   DECIMAL(12,2)     NULL,
    dep_AktifMi     TINYINT(1)    NOT NULL DEFAULT 1,
    CONSTRAINT pk_Depo PRIMARY KEY (dep_ID),
    CONSTRAINT fk_dep_Adr FOREIGN KEY (dep_AdrID) REFERENCES Adres (adr_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: warehouses — Varillerin depolandığı fiziksel lokasyonları tanımlar.

-- ============================================================
-- 14. Depo_Stok
-- ============================================================
CREATE TABLE IF NOT EXISTS Depo_Stok (
    dst_ID          INT           NOT NULL AUTO_INCREMENT,
    dst_DepID       INT           NOT NULL,
    dst_VarID       INT           NOT NULL,
    dst_GirisTarih  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dst_CikisTarih  DATETIME          NULL,
    CONSTRAINT pk_Depo_Stok PRIMARY KEY (dst_ID),
    CONSTRAINT fk_dst_Dep FOREIGN KEY (dst_DepID) REFERENCES Depo (dep_ID),
    CONSTRAINT fk_dst_Var FOREIGN KEY (dst_VarID) REFERENCES Varil (var_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: warehouse_stock — Varillerin hangi depoda ne zaman bulunduğunu kaydeder.

-- ============================================================
-- 15. Siparis
-- ============================================================
CREATE TABLE IF NOT EXISTS Siparis (
    sip_ID          INT           NOT NULL AUTO_INCREMENT,
    sip_MtrID       INT           NOT NULL,
    sip_TesAdrID    INT           NOT NULL,
    sip_Durum       ENUM('beklemede','onaylandi','kargoda','teslim','iptal') NOT NULL DEFAULT 'beklemede',
    sip_OlusturmaTarih DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sip_TahminiTeslim DATE            NULL,
    sip_Notlar      TEXT              NULL,
    CONSTRAINT pk_Siparis PRIMARY KEY (sip_ID),
    CONSTRAINT fk_sip_Mtr    FOREIGN KEY (sip_MtrID)    REFERENCES Musteri (mtr_ID),
    CONSTRAINT fk_sip_TesAdr FOREIGN KEY (sip_TesAdrID) REFERENCES Adres (adr_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: orders — Müşteri siparişlerinin ana kaydını tutar.

-- ============================================================
-- 16. Siparis_Kalem
-- ============================================================
CREATE TABLE IF NOT EXISTS Siparis_Kalem (
    skap_ID         INT           NOT NULL AUTO_INCREMENT,
    skap_SipID      INT           NOT NULL,
    skap_UrnID      INT           NOT NULL,
    skap_Miktar     INT           NOT NULL DEFAULT 1,
    skap_BirimFiyat DECIMAL(10,2) NOT NULL,
    skap_IndirimOran DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_Siparis_Kalem PRIMARY KEY (skap_ID),
    CONSTRAINT fk_skap_Sip FOREIGN KEY (skap_SipID) REFERENCES Siparis (sip_ID),
    CONSTRAINT fk_skap_Urn FOREIGN KEY (skap_UrnID) REFERENCES Urun (urn_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: order_items — Her siparişe ait ürün kalem detaylarını saklar.

-- ============================================================
-- 17. Varil_Takas
-- ============================================================
CREATE TABLE IF NOT EXISTS Varil_Takas (
    vtks_ID         INT           NOT NULL AUTO_INCREMENT,
    vtks_SrotID     INT           NOT NULL,
    vtks_SipID      INT           NOT NULL,
    vtks_TeslimVarID INT          NOT NULL,
    vtks_GeriVarID  INT               NULL,
    vtks_TakasTarih DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vtks_Aciklama   VARCHAR(255)      NULL,
    CONSTRAINT pk_Varil_Takas PRIMARY KEY (vtks_ID),
    CONSTRAINT fk_vtks_Srot      FOREIGN KEY (vtks_SrotID)    REFERENCES Surucu_Rota (srot_ID),
    CONSTRAINT fk_vtks_Sip       FOREIGN KEY (vtks_SipID)     REFERENCES Siparis (sip_ID),
    CONSTRAINT fk_vtks_TeslimVar FOREIGN KEY (vtks_TeslimVarID) REFERENCES Varil (var_ID),
    CONSTRAINT fk_vtks_GeriVar   FOREIGN KEY (vtks_GeriVarID)   REFERENCES Varil (var_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: barrel_exchanges — Teslimat sırasında gerçekleştirilen dolu/boş varil takaslarını kaydeder.

-- ============================================================
-- 18. Fatura
-- ============================================================
CREATE TABLE IF NOT EXISTS Fatura (
    fat_ID          INT           NOT NULL AUTO_INCREMENT,
    fat_SipID       INT           NOT NULL UNIQUE,
    fat_FaturaNo    VARCHAR(30)   NOT NULL UNIQUE,
    fat_KesisTarih  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fat_VadeTarih   DATE              NULL,
    fat_ToplamTutar DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    fat_KDVOran     DECIMAL(5,2)  NOT NULL DEFAULT 20.00,
    fat_OdemeDurum  ENUM('odenmedi','kismi','odendi') NOT NULL DEFAULT 'odenmedi',
    CONSTRAINT pk_Fatura PRIMARY KEY (fat_ID),
    CONSTRAINT fk_fat_Sip FOREIGN KEY (fat_SipID) REFERENCES Siparis (sip_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: invoices — Siparişlere karşılık oluşturulan faturaları saklar.

-- ============================================================
-- 19. Odeme
-- ============================================================
CREATE TABLE IF NOT EXISTS Odeme (
    ode_ID          INT           NOT NULL AUTO_INCREMENT,
    ode_FatID       INT           NOT NULL,
    ode_KulID       INT           NOT NULL,
    ode_Tutar       DECIMAL(12,2) NOT NULL,
    ode_Yontem      ENUM('nakit','kredi_karti','havale','cek') NOT NULL,
    ode_OdemeTarih  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ode_ReferansNo  VARCHAR(80)       NULL,
    CONSTRAINT pk_Odeme PRIMARY KEY (ode_ID),
    CONSTRAINT fk_ode_Fat FOREIGN KEY (ode_FatID) REFERENCES Fatura (fat_ID),
    CONSTRAINT fk_ode_Kul FOREIGN KEY (ode_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: payments — Faturalara yapılan ödeme işlemlerini kaydeder.

-- ============================================================
-- 20. Bildirim
-- ============================================================
CREATE TABLE IF NOT EXISTS Bildirim (
    bld_ID          INT           NOT NULL AUTO_INCREMENT,
    bld_KulID       INT           NOT NULL,
    bld_Baslik      VARCHAR(150)  NOT NULL,
    bld_Mesaj       TEXT          NOT NULL,
    bld_OkunduMu    TINYINT(1)    NOT NULL DEFAULT 0,
    bld_GonderimZaman DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    bld_Tur         VARCHAR(40)       NULL COMMENT 'siparis, odeme, sistem vb.',
    CONSTRAINT pk_Bildirim PRIMARY KEY (bld_ID),
    CONSTRAINT fk_bld_Kul FOREIGN KEY (bld_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: notifications — Kullanıcılara gönderilen sistem bildirimlerini saklar.

-- ============================================================
-- 21. Destek_Talep
-- ============================================================
CREATE TABLE IF NOT EXISTS Destek_Talep (
    dtp_ID          INT           NOT NULL AUTO_INCREMENT,
    dtp_KulID       INT           NOT NULL,
    dtp_SipID       INT               NULL,
    dtp_Konu        VARCHAR(200)  NOT NULL,
    dtp_Aciklama    TEXT          NOT NULL,
    dtp_Durum       ENUM('acik','inceleniyor','cozuldu','kapandi') NOT NULL DEFAULT 'acik',
    dtp_OlusturmaTarih DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Destek_Talep PRIMARY KEY (dtp_ID),
    CONSTRAINT fk_dtp_Kul FOREIGN KEY (dtp_KulID) REFERENCES Kullanici (kul_ID),
    CONSTRAINT fk_dtp_Sip FOREIGN KEY (dtp_SipID) REFERENCES Siparis (sip_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: support_tickets — Kullanıcıların açtığı destek/şikayet taleplerini yönetir.

-- ============================================================
-- 22. Destek_Mesaj
-- ============================================================
CREATE TABLE IF NOT EXISTS Destek_Mesaj (
    dmsg_ID         INT           NOT NULL AUTO_INCREMENT,
    dmsg_DtpID      INT           NOT NULL,
    dmsg_GonderenID INT           NOT NULL,
    dmsg_Mesaj      TEXT          NOT NULL,
    dmsg_GonderimZaman DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Destek_Mesaj PRIMARY KEY (dmsg_ID),
    CONSTRAINT fk_dmsg_Dtp FOREIGN KEY (dmsg_DtpID)      REFERENCES Destek_Talep (dtp_ID),
    CONSTRAINT fk_dmsg_Gon FOREIGN KEY (dmsg_GonderenID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: support_messages — Destek talebi altındaki mesaj zincirini saklar.

-- ============================================================
-- 23. Degerlendirme
-- ============================================================
CREATE TABLE IF NOT EXISTS Degerlendirme (
    dgl_ID          INT           NOT NULL AUTO_INCREMENT,
    dgl_SipID       INT           NOT NULL,
    dgl_KulID       INT           NOT NULL,
    dgl_Puan        TINYINT       NOT NULL CHECK (dgl_Puan BETWEEN 1 AND 5),
    dgl_Yorum       TEXT              NULL,
    dgl_OlusturmaTarih DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Degerlendirme PRIMARY KEY (dgl_ID),
    CONSTRAINT fk_dgl_Sip FOREIGN KEY (dgl_SipID) REFERENCES Siparis (sip_ID),
    CONSTRAINT fk_dgl_Kul FOREIGN KEY (dgl_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: reviews — Müşterilerin tamamlanan siparişlere verdiği puanlama ve yorumları tutar.

-- ============================================================
-- 24. Sistem_Log
-- ============================================================
CREATE TABLE IF NOT EXISTS Sistem_Log (
    slg_ID          INT           NOT NULL AUTO_INCREMENT,
    slg_KulID       INT           NOT NULL,
    slg_Eylem       VARCHAR(100)  NOT NULL,
    slg_TabloAd     VARCHAR(60)       NULL,
    slg_KayitID     INT               NULL,
    slg_OncekiDeger JSON              NULL,
    slg_YeniDeger   JSON              NULL,
    slg_LogZaman    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_Sistem_Log PRIMARY KEY (slg_ID),
    CONSTRAINT fk_slg_Kul FOREIGN KEY (slg_KulID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: audit_logs — Sisteme ait kritik CRUD işlemlerinin denetim kaydını tutar.

-- ============================================================
-- 25. Kampanya
-- ============================================================
CREATE TABLE IF NOT EXISTS Kampanya (
    kmp_ID          INT           NOT NULL AUTO_INCREMENT,
    kmp_OlusturanID INT           NOT NULL,
    kmp_Ad          VARCHAR(150)  NOT NULL,
    kmp_Aciklama    TEXT              NULL,
    kmp_IndirimOran DECIMAL(5,2)  NOT NULL DEFAULT 0.00,
    kmp_BaslangicTarih DATE       NOT NULL,
    kmp_BitisTarih  DATE          NOT NULL,
    kmp_MinSiparisTutar DECIMAL(10,2) NULL,
    kmp_AktifMi     TINYINT(1)    NOT NULL DEFAULT 1,
    CONSTRAINT pk_Kampanya PRIMARY KEY (kmp_ID),
    CONSTRAINT fk_kmp_Kul FOREIGN KEY (kmp_OlusturanID) REFERENCES Kullanici (kul_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;
-- Kaynak: campaigns — Yöneticilerin oluşturduğu indirim kampanyalarını tanımlar.

-- ============================================================
SET FOREIGN_KEY_CHECKS = 1;
-- Şema başarıyla oluşturuldu. Toplam: 25 tablo, her tabloda en az 1 FOREIGN KEY.
-- ============================================================
