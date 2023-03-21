# yaho

A new Yaho project.

**Lưu ý:** *Vui lòng checkout branch features để có thể pull toàn bộ source code của ứng dụng*

## Dự án được xây dựng với mục đích là 1 bài interview

### Kiến trúc và thư viện sử dụng trong dự án
- Dự án được xây dựng dựa trên clean architecture kết hợp MVVM để quản lý các state thông qua Stream và RxDart.
- Dự án chia ra cụ thể 3 môi trường development, staging và production. Tương ứng các thông số môi trường được khởi tạo khi ứng dụng chạy là các thông số cần thiết dựa trên từng môi trường cụ thể, ở đây là đang lấy giá trị domain ở trông assets/json/app_config.json.
- Dự án sử dụng Font "SFProText" được import thủ công thay cho việc sử dụng thư viện GoogleFonts.
- Dự án chỉ sử dụng các hình ảnh với phần mở rộng là .png vì không có nội dung đặc tả UI/UX dựa trên Figma (Sử dụng thư viện flutter_svg).
- Dự án sử dụng thư viện Dio và custom 2 interceptor để handle việc log ra CURL cũng như là phần request và response từ API trả về. Bên cạnh đó, sử dụng kiến trúc phân tầng dựa vào tính chất của interface để quản lý các thành phần của 1 HTTPMethod(ENDPOINT, PATH, METHOD, HEADER, QUERY, BODY) 1 cách rõ ràng trách trùng lắp và nhàm chán trong cách code.
- Dự án sử dụng thư viện get_it dùng để dependency injection các thành phần cần thiết.
- Dự án sử dụng thư viện lottie để load các annimation từ file json, sử dụng thư viện shimmer để handle các shimmer affect khi load dữ liệu, sử dụng easy_localization và flutter_easyloading để quản lý đa ngôn ngữ, sử dụng internet_connection_checker để kiểm tra trạng thái internet và handle thông báo thông qua hộp thoại dialog cho người dùng, sử dụng device_info_plus và package_info_plus để lấy thông tin của thiết bị cũng như là thông tin của ứng dụng để show thông tin chi tiết về ứng dụng (phiên bản).
- Dự án sử dụng thư viện cached_network_image để handle việc cache dữ liệu hình ảnh nhận từ các url cho việc load lại lần sau trở nên nhanh và mượt mà hơn
- Dự án sử dụng tính chất extension của dart để mở rộng và làm ngắn gọn các tính năng cần sử dụng.
- Ngoài các thư viện nêu trên, dự án cũng có custom 1 số widget tái sử dụng lại để tránh trùng lắp code và dễ dàng chỉnh sửa khi các giao diện dùng chung có sự thay đổi sau này.

### Usecase của kiến trúc đang sử dụng
- `assets`: quản lý các loại hình ảnh, fonts, đa ngôn ngữ và các file json cần thiết
- `lib/app/flavors`: có nhiệm vụ config môi trường khi ứng dụng khởi chạy để lấy các tham số cần thiết cho toàn bộ ứng dụng sử dụng sau này (domain)
- `lib/common/dialog`: Chứa các dialog UI sử dụng chung
- `lib/common/listener`: Định nghĩa các typedef để handle việc callback từ các dialog, widget về màn hình chính
- `lib/common/resource`: Chứa toàn bộ các giá trị sử dụng lập đi lập lại trong toàn bộ source code
- `lib/common/route`: Điều hướng màn hình sử dụng GlobalKey để di chuyển giữa các screen và ẩn hiện các hộp thoại
- `lib/common/widgets`: Các widget được sử dụng chung ở nhiều màn hình trong toàn bộ source code (tương tự dialog)
- `lib/core/models`: Chứa 3 loại models với mục đích sử dụng khác biệt nhau hoàn toàn:
  + `respone/parser`: Đây là dữ liệu thuần nhận trược tiếp từ việc call api. Bên cạnh đó parser đóng vai trò là cầu nối bằng cách sử dụng 1 Isolate riêng trong việc decode từ json sang response.
  + `mapper`: Dự liệu mapper có phần giống với response nhưng đây là model "sạch" được xử lý trách việc dữ liệu bị null hoặc empty, mapper sử dụng Adapter pattern và tính chất extension của Dart để chuyển đổi từ response và được dùng để hiển thị trên các UI/UX. 
  + `object`: Đây là dữ liệu dùng chung với 1 số mục đích cụ thể.
- `lib/network`: Toàn bộ phần này dùng để xử lý các yêu cầu liên quan đến API như: request, log, handle các lỗi từ api trả về,...
- `lib/services`: Đây là nơi implement các tính chất, phương thức của `network' để thực hiện việc trực tiếp lấy dữ liệu từ server (từ API) và sử dụng 2 loại models `response/parser` để xử lý dữ liệu và trả về 1 Future<T> để repository phía sau tiếp tục xử lý. Services đóng vai trò như 1 nhà máy tập hợp các thông tin từ phía người dùng và liên lạc với phía server để sau đó nhận các kết quả trả về.
- `lib/repositories`: Khác với services với vai trò tổng hợp và xử lý kết quả trả về, repository là 1 nhà máy có nhiệm vụ truyền tiếp thông tin yêu cầu từ usercase đến cho services và nhận về dữ liệu thô để sàn lọc tinh chỉnh thành dữ liệu thành phẩm "model mapper". Ngoài ra, repository còn có chức năng kiểm tra trạng thái internet bằng cách inject thư viện internet_connection_checker để trả về kết quả cho người dùng cũng như là kết qủa phản hồi (thành công, thất bại) từ server.
- `lib/usecases`: Có nhiệm vụ tổng hợp từ nhiều repository lại với chung 1 mục đích phục vụ cho 1 chức năng hay 1 màn hình cụ thể nhằm tăng tính rõ ràng của cấu trúc. Kèm theo là việc sẽ nhả ra 1 `Either` từ thư viện `dartz` giúp ích việc xử lý 2 luồng dữ liệu trả về (failure và success) 1 cách tách bạch rõ ràng.
- `lib/di`: Nơi dùng để DI các thành phần phụ thuộc lẫn nhau trong toàn bộ ứng dụng.
- `lib/presentation/..`: Chức các thành phần tương tác trực tiếp với người dùng (UI/UX) cùng với phần logic (ViewModel) của từng thành phần tương ứng trên màn hình hiển thị. Ứng dụng sử dụng state management mà framework Flutter cung cấp (Stream, StreamBuilder) kết hợp với sử dụng RxDart để xử lý các input và output cho từng features cụ thể. Cách sử dụng trên có ưu điểm và nhược điểm của nó.
  + Ưu điểm: Có sẵn trong framework Flutter nên vòng đời được Google hỗ trợ lâu dài (tránh update nhiều hoặc bị khai tử)
  + Nhược điểm: Cách sử dụng khá rờm rà so với Bloc, GetX, Provider
 - `lib/utils`: Nơi chứa các tiện ích sử dụng nhiều trong ứng dụng như phân trang, get thông tin ứng dụng, thông tin thiết bị và các extension được định nghĩa trước đó.

### Cách khởi chạy ứng dụng (CMD, VSCode, Android Studio)
- `CMD`: Khi lập trình viên muốn khởi chạy ứng dụng bằng dòng lệnh thì thực hiện với nội dung như sau:
  `flutter run --no-sound-null-safety -t lib/app/flavors/main_development.dart` cho môi trường develepment
  `flutter run --no-sound-null-safety -t lib/app/flavors/main_staging.dart` cho môi trường staging
  `flutter run --no-sound-null-safety -t lib/app/flavors/main_production.dart` cho môi trường production
  Trong đó -t là options trỏ đến đúng vị trí của hàm main tưng ứng với từng môi trường
- 'VSCode`: Dự án có tạo sẵn file `launch.json` nằm trong thư mực `.vscode`, lập trình viên chỉ cần vào phần `Run and Debug` của IDO và chọn môi trường tương ứng để khởi chạy ứng dụng như hình sau (Lưu ý cần kết nối thiết bị hoặc run máy ảo lên trước):

  ![Screen Shot 2023-03-21 at 13 30 23](https://user-images.githubusercontent.com/42068261/226533121-d288ed90-5adf-43ef-bfd1-b97b5a172777.png)
  
- `Android Studio`: Lập trình viên cần setup tường môi trường riêng bằng cách vào phần `Edit Configurations` với các thông số tương tự bên dưới. Sau khi thiết lập thì chỉ cần chọn đúng môi trường và khởi chạy ứng dụng

  ![Screen Shot 2023-03-21 at 13 36 06](https://user-images.githubusercontent.com/42068261/226533887-413785e8-d359-4e06-ac9a-467440603bd0.png)

  Với các tham số như sau:
  + Dart entrypoint: /path/to/lib/app/flavors/main_development.dart
  + Additional run args: --debug --cache-sksl --purge-persistent-cache --no-sound-null-safety
  + Build flavor: Nếu bạn có chia từng runner riêng biệt trong iOS native thì sẽ bổ sung thêm thông số tại đây

### Một số hình ảnh ứng dụng khi khởi chạy thành công

#### Splash screen

<img width="502" alt="Screen Shot 2023-03-21 at 13 40 52" src="https://user-images.githubusercontent.com/42068261/226534494-00211a1a-f8b3-47b8-9cf4-75a281ae838b.png">

#### Welcome screen
<img width="546" alt="Screen Shot 2023-03-21 at 13 41 31" src="https://user-images.githubusercontent.com/42068261/226534590-1a2bd5f3-48ed-4642-8119-07fd9a79717d.png">
<img width="546" alt="Screen Shot 2023-03-21 at 13 42 29" src="https://user-images.githubusercontent.com/42068261/226534719-2ff7ffff-c397-47b1-a26e-4bbc60dfcb4c.png">
<img width="546" alt="Screen Shot 2023-03-21 at 13 44 11" src="https://user-images.githubusercontent.com/42068261/226534948-73791774-435e-4eb5-801b-dd660cf5030a.png">

#### Contact screen (List and Grid)
<img width="546" alt="Screen Shot 2023-03-21 at 13 45 04" src="https://user-images.githubusercontent.com/42068261/226535067-6666677f-409e-4e97-be03-7151a7a5f19c.png">
<img width="546" alt="Screen Shot 2023-03-21 at 13 45 26" src="https://user-images.githubusercontent.com/42068261/226535108-205d7d6e-74d8-4d12-b6b0-845c4cb1f60f.png">

## Tóm lại
Ứng dụng trên là các kiến thức dựa trên kinh nghiệm nhiều năm làm việc với Flutter. Tuy vẫn còn nhiều tính năng và kiến thức chưa thể tích hợp ứng dụng do thời gian hạn chế và ngữ cảnh không thích hợp. Cuối, Em/Tôi xin cảm ơn phía công ty (PLUSTEAM) đã đánh giá tốt và tạo điều kiện để em/tôi thực hiện bài test, em/tôi mong muốn phía công ty (PLUSTEAM) sẽ xem xét và đánh giá dựa trên cách nhìn khách quan và đóng góp những yếu kém, thiếu sót để em/tôi có thể lắng nghe để cải thiện và ứng dụng vào trong career dev dạo trong tương lai ^^. Một lần nữa xin chân thành cảm ơn các anh/chị/em review đã dành thời gian để đọc README và chúc công ty (PLUSTEAM) và mọi người có nhiều sức khoẻ) 
