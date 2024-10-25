# SwiftUI Design Patterns

## MVC (Model-View-Controller)

- **Model:** ประกอบด้วยโครงสร้างข้อมูลที่แทนวัตถุในแอปพลิเคชัน เช่น ผู้ใช้ (User), สินค้า (Product) หรือเหตุการณ์ (Event) และทำหน้าที่เป็นแหล่งข้อมูลของแอป
- **View:** แสดงผล UI โดยการสร้าง View ใน SwiftUI เช่น หน้าจอล็อกอิน, หน้ารายการสินค้า หรือหน้ารายละเอียดสินค้า
- **Controller:** รับผิดชอบการเชื่อมต่อระหว่าง Model และ View โดยการจัดการข้อมูลและการโต้ตอบจากผู้ใช้ เช่น การดึงข้อมูลผู้ใช้จากฐานข้อมูลและแสดงผลบนหน้าจอ

### การใช้งาน
- เหมาะสำหรับโครงการที่มีการแยกหน้าที่ที่ชัดเจนระหว่างข้อมูล (Model), การแสดงผล (View) และการควบคุมการดำเนินงาน (Controller)
- ทำงานได้ดีสำหรับโครงการที่ไม่ซับซ้อนมาก


## MVVM (Model-View-ViewModel)

- **Model:** โครงสร้างข้อมูลที่แทนวัตถุในแอปพลิเคชัน เช่น ผู้ใช้ (User), สินค้า (Product) หรือเหตุการณ์ (Event)
- **View:** แสดงผล UI โดยใช้ SwiftUI เช่น เลย์เอาต์สำหรับข้อมูลผู้ใช้และองค์ประกอบส่วนติดต่ออื่นๆ
- **ViewModel:** จัดการสถานะและการนำเสนอของ View โดยตรง เช่น การตรวจสอบข้อมูลก่อนการแสดงผลและการจัดรูปแบบข้อมูลเพื่อให้แสดงผลได้อย่างเหมาะสม

### การใช้งาน
- เหมาะสำหรับโครงการที่มีการจัดการข้อมูลที่ซับซ้อน ViewModel จะเปลี่ยนรูปแบบและเตรียมข้อมูลสำหรับ View เพื่อให้แสดงผลได้อย่างถูกต้อง
- มีประสิทธิภาพสำหรับแอปพลิเคชันที่มี UI ซับซ้อนและข้อมูลที่ได้รับการอัปเดตบ่อยครั้ง


## MVP (Model-View-Presenter)

- **Model:** โครงสร้างข้อมูลที่แทนวัตถุในแอปพลิเคชัน เช่น ผู้ใช้ (User), สินค้า (Product) หรือเหตุการณ์ (Event)
- **View:** รับผิดชอบในการแสดงข้อมูลและการโต้ตอบกับผู้ใช้ โดยใช้ SwiftUI เช่น แบบฟอร์มสมัครสมาชิก, หน้าหลัก หรือหน้าการตั้งค่า
- **Presenter:** ทำหน้าที่เป็นสื่อกลางระหว่าง Model และ View โดยรับผิดชอบในการตอบสนองจากผู้ใช้และประมวลผลข้อมูล เช่น การตรวจสอบการตั้งค่าและการอัปเดตการแสดงผล

### การใช้งาน
- เหมาะสำหรับโครงการที่มีการแยกหน้าที่การแสดงข้อมูลและการจัดการข้อมูลอย่างชัดเจน
- Presenter ทำหน้าที่เป็นช่องทางการสื่อสารระหว่าง Model และ View โดยไม่สร้างการเชื่อมต่อโดยตรงระหว่าง View และ Model


## VIPER (View-Interactor-Presenter-Entity-Routing)

- **View:** แสดงผลและโต้ตอบกับผู้ใช้ โดยใช้ SwiftUI ซึ่งไม่รับผิดชอบในการประมวลผลข้อมูล
- **Interactor:** รับผิดชอบในการจัดการข้อมูลและธุรกรรมทางธุรกิจ เช่น การดึงข้อมูลจากเซิร์ฟเวอร์, การจัดการข้อมูล หรือการโต้ตอบกับฐานข้อมูล
- **Presenter:** จัดการการแสดงผลและการประมวลผลข้อมูล เช่น การตั้งค่ารูปแบบข้อมูลเพื่อการแสดงผล และการควบคุมกระบวนการโดยตรง
- **Entity:** โครงสร้างข้อมูลที่แทนวัตถุในแอปพลิเคชัน ใช้เป็นฐานข้อมูลหรือตัวแทนข้อมูล
- **Routing:** จัดการการเปลี่ยนแปลงและการนำทางระหว่างหน้าจอ เช่น การสร้างเส้นทางการนำทางและการนำทางผ่านหน้าจอ

### การใช้งาน
- เหมาะสำหรับโครงการที่ซับซ้อนและมีความสำคัญต่อการทดสอบ โดยการแบ่งหน้าที่ออกเป็นชั้นงาน
- แต่ละส่วนจะทำงานอย่างอิสระและเชื่อมต่อกันผ่านอินเทอร์เฟซ

