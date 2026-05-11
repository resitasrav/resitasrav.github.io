# 🗄️ Lojistik Veritabanı Şema Tasarımı

> **Bilgisayar Mühendisliği — 2. Sınıf / Proje 1 — Veritabanı Tasarım Ödevi**

## 📌 Proje Bilgileri

| Alan | Değer |
|---|---|
| **Ders** | Veritabanı Yönetim Sistemleri |
| **Proje** | Proje 1 — Veritabanı Tasarımı |
| **Konu** | Lojistik & Sipariş Yönetim Sistemi |
| **Tablo Sayısı** | 25 |
| **Diyagram Türleri** | Chen Notasyonu, Kaz Ayağı (Crow's Foot), Kaz Ayağı Şeması |

## 👥 Ekip Üyeleri ve Sorumluluk Alanları

| Üye | Modül | Yönettiği Tablolar |
|---|---|---|
| **Özgür KOTBAŞ** | Kullanıcı & Kimlik | Rol, Kullanıcı, Adres, Müşteri, Bildirim, Sistem_Log |
| **Bedirhan GÖK** | Sürücü & Lojistik | Sürücü_Profil, Araç, Güzergah, Sürücü_Rota, Konum_Takip, Varil_Takas |
| **Bilal DOĞRU** | Ürün & Depo | Ürün_Kategori, Ürün, Varil, Depo, Depo_Stok, Kampanya |
| **Reşit ASRAV** | Sipariş & Fatura | Sipariş, Sipariş_Kalem, Fatura, Ödeme, Destek_Talep, Destek_Mesaj, Değerlendirme |

## 🔗 Canlı Önizleme

| Görünüm | Bağlantı |
|---|---|
| Kaz Ayağı Diyagramı | [kazayagi_diyagram.html](https://resitasrav.github.io/kazayagi_diyagram.html) |
| Chen Notasyonu | [chen_diagram.html](https://resitasrav.github.io/chen_diagram.html) |
| Veritabanı Şeması | [veritabani_sema.html](https://resitasrav.github.io/veritabani_sema.html) |

---

## 📂 Proje Yapısı

```
weritabanı şemaları/
├── kazayagi_diyagram.html   ← Kaz Ayağı (Crow's Foot) — kişi bazlı renklendirme
├── chen_diagram.html        ← Chen ER Diyagramı — akademik notasyon
├── veritabani_sema.html     ← Kaz Ayağı Şeması — sade ilişki görünümü
├── schema.sql               ← Tüm tabloların SQL CREATE komutları
├── csv/
│   ├── tablolar.csv         ← Tablo listesi
│   ├── sutunlar.csv         ← Sütun detayları (PK/FK, tip)
│   └── iliskiler.csv        ← Tablolar arası ilişkiler
├── images/                  ← Ekip üyesi profil fotoğrafları
├── drawio/                  ← draw.io diyagram dosyaları
└── pdfs/                    ← Dışa aktarılmış PDF dokümanları
```

## 🚀 Özellikler

### 1. Üç Farklı Diyagram Görünümü
Proje, veritabanı şemasını üç farklı standartta inceleme imkânı sunar. Her sayfanın üst menüsündeki butonlarla görünümler arası geçiş yapılabilir.

*   **Kaz Ayağı Diyagramı (`kazayagi_diyagram.html`)** — Tabloların fiziksel yapısını, sütun detaylarını (PK/FK) ve N:1 ilişkileri kart tasarımıyla gösterir. Kişi bazlı renklendirme ve filtreleme içerir.
*   **Chen Notasyonu (`chen_diagram.html`)** — Akademik ER modellemesi. Zayıf varlıklar, türetilmiş ve çok değerli öznitelikler ile tanımlayıcı ilişkileri geometrik şekillerle çizer.
*   **Veritabanı Şeması (`veritabani_sema.html`)** — Tüm tabloları ve FK ilişkilerini sade bir düzende gösteren hafif görünüm.

### 2. Canlı Arama ve Otomatik Odaklanma
Arama çubuğuna tablo veya sütun adı yazıldığında eşleşmeyen alanlar karartılır, bulunan tablo vurgulanır ve kamera otomatik olarak üzerine kayar.

### 3. Karanlık / Aydınlık Tema
Her üç diyagramda da tek tuşla tema geçişi yapılabilir.

### 4. HD SVG Dışa Aktarma
**"📸 İndir"** butonu ile diyagram yüksek çözünürlüklü vektörel `.svg` dosyası olarak kaydedilir.

### 5. SQL Kodu Üretimi
Tabloya çift tıklandığında `CREATE TABLE` SQL komutlarını gösteren bir pencere açılır.

### 6. İstatistik Paneli
Chen diyagramında sol alt köşede toplam tablo, ilişki ve öznitelik istatistikleri dinamik olarak gösterilir.

### 7. Ekip Filtreleme ve Bilgi Paneli
Kaz Ayağı diyagramındaki Legend bölümünden kişi bazlı filtreleme yapılabilir. "Bilgi" butonuyla her ekip üyesinin sorumluluk alanı detaylı incelenir.

---

## 💻 Kurulum ve Kullanım

Hiçbir kurulum gerektirmez. HTML dosyalarından birini tarayıcıda açmak yeterlidir.

| İşlem | Nasıl |
|---|---|
| Kamerayı kaydır | Boş alana tıkla + sürükle |
| Yakınlaş / Uzaklaş | Fare tekerleği (scroll) |
| Tablo taşı | Tabloya tıkla + sürükle |
| SQL kodunu gör | Tabloya çift tıkla |
| Görünüm değiştir | Üst menüdeki geçiş butonları |

## 🛠️ Teknik Altyapı

*   **HTML5 & CSS3** — Responsive ve modern arayüz tasarımı
*   **Vanilla JavaScript** — Hiçbir harici kütüphane kullanılmamıştır
*   **SVG Rendering** — Çizgiler ve geometriler DOM üzerinde matematiksel olarak hesaplanır
*   **CSV Veri Çıktıları** — Tablo, sütun ve ilişki verileri CSV formatında dışa aktarılmıştır
