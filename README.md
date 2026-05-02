# 🗄️ Lojistik Veritabanı Şema Görselleştirici

👉 **Canlı Önizleme (Kaz Ayağı Diyagramı):** [https://resitasrav.github.io/diyagram.html](https://resitasrav.github.io/diyagram.html)
👉 **Canlı Önizleme (Chen Notasyonu):** [https://resitasrav.github.io/chen_diagram.html](https://resitasrav.github.io/chen_diagram.html)

Bu proje, 25 tablodan oluşan kapsamlı bir lojistik veritabanının yapısını, ilişkilerini ve özniteliklerini görselleştirmek için geliştirilmiş **tamamen interaktif** ve **akademik düzeyde** bir web uygulamasıdır. Herhangi bir sunucuya veya dış bağımlılığa (veritabanı bağlantısına) ihtiyaç duymadan doğrudan tarayıcı üzerinden çalışır.

## 🚀 Öne Çıkan Özellikler

### 1. Çift Modlu Görselleştirme
Proje, veritabanı şemasını iki farklı endüstri standardında inceleme fırsatı sunar:
*   **Kaz Ayağı (Crow's Foot) Diyagramı (`diyagram.html`)**: Tabloların fiziksel yapısını, sütun detaylarını (PK/FK) ve N:1 ilişkileri modern bir "kart" tasarımıyla gösterir. Kişi/sorumluluk bazlı renklendirme ve filtreleme içerir.
*   **Chen Notasyonu (`chen_diagram.html`)**: Akademik ER modellemesi için geliştirilmiştir. Zayıf varlıklar (Weak Entities), türetilmiş öznitelikler (Derived Attributes), çok değerli öznitelikler (Multi-valued Attributes) ve tanımlayıcı ilişkileri (Identifying Relationships) uluslararası standartlardaki geometrik şekillerle çizer.

### 2. Canlı Arama ve Otomatik Odaklanma (Search & Focus)
Üst menüdeki arama çubuğuna bir tablo veya sütun adı yazdığınızda, sistem eşleşmeyen alanları karartır ve eşleşen tabloyu neon sarısı bir ışıkla vurgular. Ardından kamera pürüzsüz bir animasyonla aranan tablonun üzerine odaklanır.

### 3. Karanlık/Aydınlık Tema Desteği
Göz yorgunluğunu önlemek ve sunum ortamına uyum sağlamak için her iki diyagramda da tek tuşla **Aydınlık/Karanlık Tema** geçişi yapılabilir.

### 4. HD SVG Dışa Aktarma (Export)
Oluşturduğunuz şemanın kalitesi bozulmadan projelerinize veya sunumlarınıza ekleyebilmeniz için **"📸 İndir"** butonu bulunur. Bu buton, ekrandaki her şeyi (tema moduna uygun olarak) yüksek çözünürlüklü vektörel bir `.svg` dosyası haline getirip bilgisayarınıza kaydeder.

### 5. Anında SQL Kodu Üretimi
Diyagram üzerinde gezinirken ilgilendiğiniz tablonun üzerine **çift tıkladığınızda**, o tablonun veritabanında nasıl oluşturulacağını gösteren `CREATE TABLE` SQL komutlarını içeren şık bir kod penceresi açılır. Birincil ve ikincil anahtarları otomatik olarak saptar.

### 6. İnteraktif İstatistik Paneli
Chen diyagramı açıkken sol alt köşede, sistemin anlık bir özetini sunan istatistik paneli bulunur. Toplam tablo sayısı, ilişki tipleri ve öznitelik türlerini (PK, Türetilmiş vb.) dinamik olarak hesaplar.

### 7. Ekip ve Sorumluluk Alanı Yönetimi (Legend & Filtreleme)
Veritabanı yapısı, sistemin modülerliğini ve proje dağılımını yansıtacak şekilde 4 ana gruba ayrılmış ve her biri projeyi geliştiren bir ekip üyesine atanmıştır:
*   **Özgür KOTBAŞ (Kullanıcı & Kimlik):** Kullanıcı rolleri, adresler, müşteri profilleri, bildirimler ve sistem loglamaları.
*   **Bedirhan GÖK (Sürücü & Lojistik):** Filo yönetimi, sürücü atamaları, güzergah takibi ve sahada gerçekleşen varil takas işlemleri.
*   **Bilal DOĞRU (Ürün & Depo):** Ürün kataloğu, varil kapasite ve stok durumları, depo hareketleri ve pazarlama kampanyaları.
*   **Reşit ASRAV (Sipariş & Fatura):** Sipariş ve kalem yönetimi, tahsilat, faturalandırma, destek talepleri ve değerlendirme süreçleri.

Diyagram üzerindeki interaktif *Legend* bölümünden istenilen kişilerin filtrelemesi yapılarak yalnızca o ekibe ait tablolar aydınlatılabilir. Ek olarak, "Bilgi" paneli ile kişilerin sistemin bütünüyle nasıl bağlantı kurduğu detaylı olarak incelenebilir.

---

## 💻 Kurulum ve Kullanım

Hiçbir kurulum gerektirmez! 

1. Klasördeki `diyagram.html` veya `chen_diagram.html` dosyalarından birine çift tıklayarak modern bir tarayıcıda (Chrome, Edge, Safari vb.) açın.
2. **Kamerayı Hareket Ettirmek İçin:** Arka planda boş bir alana tıklayıp sürükleyin.
3. **Yakınlaşmak / Uzaklaşmak İçin:** Farenizin tekerleğini (scroll) kullanın.
4. **Tabloları Taşımak İçin:** İstediğiniz tablonun veya elipsin üzerine tıklayıp sürükleyerek diyagramı kendi isteğinize göre düzenleyebilirsiniz.
5. Menüdeki butonlar aracılığıyla şemalar arası geçiş yapabilir veya dağınık tabloları tek tuşla toplayabilirsiniz.

## 🛠️ Teknik Altyapı
*   **HTML5 & CSS3:** Modern ve akıcı arayüz tasarımı.
*   **Vanilla JavaScript:** Veri manipülasyonu, SVG çizimleri ve fiziksel pan/zoom hesaplamaları için hiçbir harici kütüphane (ör. jQuery, React) kullanılmamıştır.
*   **SVG Rendering:** Çizgiler ve vektörel geometriler anlık olarak DOM üzerinde matematiksel olarak hesaplanıp çizilir.

---
*Bu proje, veritabanı mimarisini anlamak, sunmak ve modifiye etmek isteyen herkes için mükemmel bir yardımcı araçtır.*
