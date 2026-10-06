-- =========================================================
-- CHILLI HUB TRANSLATOR V11.2 FINAL (PREMIUM UI + EXACT/MAP DICT)
-- Cơ chế: Polling 0.5s - Không hook event - Chống lag tuyệt đối
-- Ưu tiên: EXACT_MATCH_VI → MAP_VI (exact) → MAP_VI (gsub fallback)
-- UI: Glassmorphism Premium với animation Back-Ease
-- =========================================================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local SCRIPT_URL = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"

-- =========================================================
-- TỪ ĐIỂN 1: KHỚP CHÍNH XÁC (nhanh nhất, ưu tiên cao)
-- =========================================================
local EXACT_MATCH_VI = {
    -- Chung
    ["Chilli Hub"] = "Chilli Hub V3",
    ["Hop"] = "Đổi Server",
    ["Join"] = "Vào Phòng",
    ["Copy"] = "Sao Chép",
    ["Rejoin"] = "Vào Lại",
    ["Add"] = "Thêm",
    ["Sell"] = "Bán",
    ["Favorite"] = "Khóa",
    ["Unfavorite"] = "Mở Khóa",
    ["RESET"] = "ĐẶT LẠI",
    ["All"] = "Tất cả",
    ["ALL"] = "TẤT CẢ",
    ["Any"] = "Tất cả",
    ["None"] = "Không có",
    ["Off"] = "Tắt",
    ["OFF"] = "TẮT",
    ["On"] = "Bật",
    ["ON"] = "BẬT",
    ["Idle"] = "Đang chờ",
    ["IDLE"] = "ĐANG CHỜ",
    ["Stand"] = "Đứng yên",
    ["Chase"] = "Đuổi theo",
    ["Circle"] = "Xoay vòng",
    ["Patrol"] = "Tuần tra",
    ["Rarest"] = "Hiếm nhất",
    ["Nearest"] = "Gần nhất",
    ["Always"] = "Luôn luôn",
    ["Never"] = "Không bao giờ",
    ["Value"] = "Giá trị",
    ["Normal"] = "Bình Thường",
    ["Steps"] = "Từng Bước",
    ["Fast Delivery"] = "Giao Hàng Nhanh",
    ["Cancel"] = "Hủy",
    ["Turn On"] = "Bật Lên",
    ["WARNING"] = "CẢNH BÁO",
    ["selected"] = "đã chọn",

    -- Độ hiếm
    ["Cosmic"] = "Vũ Trụ (Cosmic)",
    ["Divine"] = "Thánh Thần (Divine)",
    ["Eternal"] = "Vĩnh Cửu (Eternal)",
    ["Mythic"] = "Thần Thoại (Mythic)",
    ["Legendary"] = "Huyền Thoại (Legendary)",
    ["Epic"] = "Sử Thi (Epic)",
    ["Rare"] = "Hiếm (Rare)",
    ["Uncommon"] = "Thường (Uncommon)",
    ["Common"] = "Phổ Thông (Common)",
    ["Secret"] = "Bí Ẩn (Secret)",
    ["3 - Rare"] = "3 - Hiếm (Rare)",
    ["6 - Mythic"] = "6 - Thần Thoại (Mythic)",

    -- Chế độ chọn
    ["Least Players"] = "Ít người chơi nhất",
    ["Steal Then Hop"] = "Cướp xong đổi server",
    ["Rarity Only"] = "Chỉ theo độ hiếm",
    ["Rarity And Value"] = "Độ hiếm & Giá trị",
    ["Value Only"] = "Chỉ theo giá trị",
    ["Lowest Rarity First"] = "Độ hiếm thấp trước",
    ["Lowest To Highest"] = "Từ thấp đến cao",
    ["Highest To Lowest"] = "Từ cao đến thấp",
    ["Match All"] = "Khớp tất cả",
    ["Match Any"] = "Khớp bất kỳ",
    ["Highest Value"] = "Giá trị cao nhất",
    ["Lowest Value"] = "Giá trị thấp nhất",

    -- Chữ viết hoa
    ["EGGS"] = "TRỨNG",
    ["READY"] = "SẴN SÀNG",
    ["GROWING"] = "ĐANG LỚN",
    ["IN BAG"] = "TRONG TÚI",
    ["TOTAL / S"] = "TỔNG / GIÂY",
    ["SCRAMBLED"] = "ĐÃ BIẾN ĐỔI",
    ["GOLDEN"] = "VÀNG",
    ["SILVER"] = "BẠC",
    ["RAINBOW"] = "CẦU VỒNG"
}

-- =========================================================
-- TỪ ĐIỂN 2: THAY THẾ CỤM TỪ (fallback, xử lý câu dài)
-- =========================================================
local MAP_VI = {
    -- Tab chính
    ["Chilli Hub"] = "Chilli Hub V3",
    ["Farm"] = "Cày Cuốc",
    ["Player"] = "Người Chơi",
    ["Predictor"] = "Dự Đoán",
    ["Progress"] = "Tiến Trình",
    ["Server"] = "Máy Chủ",
    ["Misc"] = "Khác",
    ["Auto Hop"] = "Tự Đổi Server",
    ["Discord"] = "Discord",
    ["Quick & Keys"] = "Phím Tắt & Key",
    ["Settings"] = "Cài Đặt",
    ["Config"] = "Cấu Hình",
    ["Filter features..."] = "Lọc tính năng...",
    ["Search"] = "Tìm kiếm",

    -- Sự kiện
    ["Dr Scramble Lab & Mech"] = "Phòng Lab & Robot Scramble",
    ["Butterfly Bloom"] = "Sự Kiện Bắt Bướm",
    ["Wisp Companion"] = "Đồng Hành Wisp",

    -- Auto Steal (Tự Động Cướp)
    ["Auto Steal"] = "Tự Động Cướp Trứng",
    ["Tự Động Cướp Trứng"] = "Tự Động Cướp Trứng",
    ["Tự Động Cướp"] = "Tự Động Cướp",
    ["Instant Steal"] = "Cướp Siêu Tốc (Instant Steal)",
    ["Cuớp Siêu Tốc (Instant Steal)"] = "Cướp Siêu Tốc (Instant Steal)",
    ["Cuớp Siêu Tốc (Instant Steal) V2"] = "Cướp Siêu Tốc (Instant Steal) V2",
    ["Delivers the egg to the safe zone in a few seconds, needs enough Speed"] = "Chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)",
    ["Chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)"] = "Chuyển trứng về căn cứ trong vài giây (cần đủ tốc độ)",
    ["Only works in Titan Temple, Light Dark and Enchanted Forest"] = "Chỉ hoạt động ở Đền Titan, Rừng Sáng Tối và Rừng Phù Phép",
    ["Other Zones Delivery"] = "Giao Trứng Khu Vực Khác",
    ["How eggs outside Titan Temple, Light Dark and Enchanted Forest come home"] = "Cách trứng ngoài Đền Titan, Rừng Sáng Tối và Rừng Phù Phép được mang về",
    ["Delivers the same way as Cuớp Siêu Tốc (Instant Steal) V2 instead of using steps"] = "Giao trứng giống như Cướp Siêu Tốc V2 thay vì dùng từng bước",
    ["Instant Steal Steps"] = "Số Bước Cướp Siêu Tốc",
    ["Số Bước Cướp Siêu Tốc"] = "Số Bước Cướp Siêu Tốc",
    ["Higher is safer but takes longer"] = "Càng nhiều bước càng an toàn nhưng bay chậm hơn",
    ["Càng nhiều bước càng an toàn nhưng bay chậm hơn"] = "Càng nhiều bước càng an toàn nhưng bay chậm hơn",
    ["Target Areas"] = "Khu Vực Mục Tiêu",
    ["Khu Vực Mục Tiêu"] = "Khu Vực Mục Tiêu",
    ["Min Rarity"] = "Độ Hiếm Tối Thiểu",
    ["Steal eggs of the chosen rarity and every rarity above it"] = "Cướp trứng từ độ hiếm đã chọn trở lên",
    ["Min Steal Value"] = "Giá Trị Cướp Min",
    ["Giá Trị Cướp Min"] = "Giá Trị Cướp Min",
    ["Target Specific Eggs"] = "Chọn Đích Danh Trứng Cần Cướp",
    ["Steal Missing Lab Eggs"] = "Cướp Trứng Lab Còn Thiếu",
    ["Steal Missing Index Eggs"] = "Cướp Trứng Sách Còn Thiếu",
    ["Also steal eggs missing from your index, highest area first"] = "Cướp cả trứng còn thiếu trong sách, ưu tiên khu cao nhất",
    ["Steal Priority"] = "Ưu Tiên Cướp",
    ["Carry Speed"] = "Tốc Độ Bê Trứng",
    ["Over 100% may glitch"] = "Trên 100% có thể bị lỗi vị trí",
    ["Anti Guard Panel"] = "Bảng Chống Vệ Sĩ",
    ["Anti Guard"] = "Chống Vệ Sĩ",

    -- Auto Place Egg
    ["Auto Place Egg"] = "Tự Động Đặt Trứng",
    ["Place Egg Rule"] = "Quy Tắc Đặt Trứng",
    ["Place Egg Order"] = "Thứ Tự Đặt Trứng",
    ["Place Rarities"] = "Độ Hiếm Đặt Trứng",
    ["Only place eggs of the picked rarities (empty = all)"] = "Chỉ đặt trứng thuộc các độ hiếm đã chọn (trống = tất cả)",
    ["Place Specific Eggs"] = "Chọn Đích Danh Trứng Cần Đặt",
    ["Only place these eggs (empty = all)"] = "Chỉ đặt các trứng này (trống = tất cả)",
    ["Min Place Value"] = "Giá Trị Đặt Min",
    ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị thấp hơn mức này (0 = tắt)",
    ["Stay On Treadmill"] = "Cố Định Trên Máy Tập",
    ["Auto Treadmill"] = "Tự Động Máy Tập",

    -- Auto Hatch
    ["Auto Hatch & Equip"] = "Tự Ấp Trứng & Trang Bị",
    ["Auto Hatch"] = "Tự Động Ấp Trứng",
    ["Hatch Min Rarity"] = "Độ Hiếm Ấp Min",
    ["Hatch eggs of the chosen rarity and every rarity above it"] = "Ấp trứng từ độ hiếm đã chọn trở lên",
    ["Min Hatch Value"] = "Giá Trị Ấp Min",
    ["Hatch Specific Eggs"] = "Chọn Đích Danh Trứng Cần Ấp",
    ["Auto Equip Best"] = "Tự Trang Bị Pet Tốt Nhất",
    ["Equip Best when a better pet appears"] = "Tự trang bị khi có pet mạnh hơn xuất hiện",

    -- Auto Sell
    ["Auto Sell"] = "Tự Động Bán",
    ["Auto Sell Pet"] = "Tự Động Bán Pet",
    ["Auto Sell Egg"] = "Tự Động Bán Trứng",
    ["Auto Sell Lab Egg"] = "Tự Động Bán Trứng Lab",
    ["Sell Pets Now"] = "Bán Pet Ngay",
    ["Sell matching pets once"] = "Bán các pet khớp điều kiện một lần",
    ["Sell Pet Rule"] = "Quy Tắc Bán Pet",
    ["Which checks must pass to sell"] = "Các điều kiện bắt buộc để bán",
    ["Pet Max Rarity"] = "Độ Hiếm Pet Max Cần Bán",
    ["Sell pets at or below this rarity"] = "Bán pet từ độ hiếm này trở xuống",
    ["Pet Sell Value"] = "Giá Trị Bán Pet Min",
    ["Sell pets worth less than this (0 = off)"] = "Bán pet có giá trị nhỏ hơn mức này (0 = tắt)",
    ["Keep Mutated Pets"] = "Giữ Lại Pet Đột Biến",
    ["Never sell mutated pets"] = "Không bao giờ bán pet có đột biến",
    ["Blacklist Sell Pets"] = "Danh Sách Đen Bán Pet",
    ["These pets are never sold"] = "Những pet này sẽ không bao giờ bị bán",
    ["Sell bag eggs matching the rules below"] = "Bán trứng trong túi khớp quy tắc dưới",
    ["Sell Eggs Now"] = "Bán Trứng Ngay",
    ["Sell matching eggs once"] = "Bán một lần các trứng khớp điều kiện",
    ["Sell Egg Rule"] = "Quy Tắc Bán Trứng",
    ["Egg Max Rarity"] = "Độ Hiếm Trứng Max Cần Bán",
    ["Sell eggs at or below this rarity"] = "Bán trứng từ độ hiếm này trở xuống",
    ["Egg Sell Value"] = "Giá Trị Bán Trứng Min",
    ["Keep Mutated Eggs"] = "Giữ Lại Trứng Đột Biến",
    ["Never sell mutated eggs"] = "Không bao giờ bán trứng có đột biến",
    ["Blacklist Sell Eggs"] = "Danh Sách Đen Bán Trứng",
    ["These eggs are never sold"] = "Những trứng này sẽ không bao giờ bị bán",
    ["Sell eggs traded from Dr Scramble that match the filters below"] = "Bán trứng đổi từ Dr Scramble khớp bộ lọc dưới",
    ["Sell Lab Eggs Now"] = "Bán Trứng Lab Ngay",
    ["Sell matching Lab eggs once"] = "Bán một lần các trứng Lab khớp điều kiện",
    ["Sell Lab Egg Rule"] = "Quy Tắc Bán Trứng Lab",
    ["Lab Egg Max Rarity"] = "Độ Hiếm Trứng Lab Max Cần Bán",
    ["Sell Lab eggs at or below this rarity (Off = none by rarity)"] = "Bán trứng Lab từ độ hiếm này trở xuống (Off = tắt)",
    ["Lab Egg Sell Value"] = "Giá Trị Bán Trứng Lab Min",
    ["Sell Lab eggs worth less than this (0 = off)"] = "Bán trứng Lab giá trị thấp hơn mức này (0 = tắt)",
    ["Keep Mutated Lab Eggs"] = "Giữ Lại Trứng Lab Đột Biến",
    ["Never sell mutated Lab eggs"] = "Không bao giờ bán trứng Lab có đột biến",
    ["Keep Lab Pets"] = "Giữ Lại Pet Lab",
    ["Lab eggs of these pets are never sold"] = "Trứng Lab của những pet này sẽ không bao giờ bị bán",

    -- Auto Fuse
    ["Auto Fuse Machine"] = "Máy Dung Hợp Pet",
    ["No three matching pets"] = "Không đủ 3 pet trùng khớp",
    ["Fuse 3 same pets into an egg, nonstop"] = "Ghép 3 pet cùng loại thành 1 trứng liên tục",
    ["Fuse Priority Mode"] = "Chế Độ Ưu Tiên Dung Hợp",
    ["Pets To Use"] = "Loại Pet Sử Dụng",
    ["Max Rarity to Fuse"] = "Độ Hiếm Dung Hợp Max",
    ["Specific Species to Fuse"] = "Chỉ Định Loài Cần Dung Hợp",
    ["Only fuse these species (empty = all)"] = "Chỉ ghép loài này (trống = tất cả)",
    ["Skip Mutated Pets"] = "Bỏ Qua Pet Đột Biến",
    ["Eject Incomplete Slots"] = "Nhả Các Ô Chưa Đủ Bộ",
    ["Take out pets that can't make a set"] = "Đẩy ra các pet không thể ghép đủ bộ 3",

    -- Auto Favorite
    ["Auto Favorite"] = "Tự Động Khóa Pet",
    ["Auto Favorite Pet"] = "Tự Động Khóa Pet",
    ["Favorite pets matching the rules below"] = "Khóa các pet khớp quy tắc bên dưới",
    ["Favorite Pets Now"] = "Khóa Pet Ngay",
    ["Favorite matching pets once"] = "Khóa các pet khớp điều kiện một lần",
    ["Favorite Rule"] = "Quy Tắc Khóa",
    ["Pass any check or all checks"] = "Thỏa mãn một hoặc tất cả điều kiện",
    ["Favorite Min Rarity"] = "Độ Hiếm Khóa Min",
    ["Favorite pets of the chosen rarity and every rarity above it (Off = skip)"] = "Khóa pet từ độ hiếm đã chọn trở lên (Off = bỏ qua)",
    ["Favorite Mutations"] = "Đột Biến Cần Khóa",
    ["Mutation check (empty = skip)"] = "Kiểm tra đột biến (trống = bỏ qua)",
    ["Min Favorite Value"] = "Giá Trị Khóa Min",
    ["Value check (0 = skip)"] = "Kiểm tra giá trị (0 = bỏ qua)",
    ["Always Favorite Species"] = "Luôn Khóa Các Loài Này",
    ["Always favorite these species"] = "Luôn luôn khóa những loài này",
    ["Auto Favorite Equipped"] = "Tự Khóa Pet Đang Dùng",
    ["Keep equipped pets favorited"] = "Luôn giữ pet đang trang bị được khóa",
    ["Auto Unfavorite Equipped"] = "Tự Bỏ Khóa Pet Đang Dùng",
    ["Unfavorite equipped pets not in the rules"] = "Mở khóa pet đang trang bị nếu không đúng quy tắc",
    ["Favorite Equipped Now"] = "Khóa Pet Đang Dùng Ngay",
    ["Favorite all equipped pets once"] = "Khóa tất cả pet đang trang bị một lần",
    ["Unfavorite Equipped Now"] = "Bỏ Khóa Pet Đang Dùng Ngay",
    ["Unfavorite all equipped pets once"] = "Mở khóa tất cả pet đang trang bị một lần",

    -- Dr Scramble / Lab / Mech
    ["Dr Scramble Event"] = "Sự Kiện Dr Scramble",
    ["Auto Mech Boss"] = "Tự Động Đánh Boss Robot",
    ["Mech Tween Speed"] = "Tốc Độ Bay Đánh Boss",
    ["Mech Tốc Độ Bay (Tween)"] = "Tốc Độ Bay Đánh Boss",
    ["Main Weapon Hold"] = "Thời Gian Giữ Vũ Khí Chính",
    ["Scrambler Hold"] = "Thời Gian Giữ Súng Biến Đổi",
    ["Swap Two Weapons"] = "Tự Đổi Qua Lại 2 Vũ Khí",
    ["Boss Server Hop"] = "Tự Đổi Server Săn Boss",
    ["Boss Đổi Máy Chủ Ngay"] = "Tự Đổi Server Săn Boss",
    ["After each boss, hops to a less crowded server to fight again"] = "Sau mỗi boss, đổi sang server vắng hơn để đánh tiếp",
    ["Keep Hopping For"] = "Thời Gian Đổi Server Liên Tục",
    ["Keeps fighting every boss it finds and hopping for this long"] = "Liên tục săn boss tìm được và đổi server trong thời gian này",
    ["Auto Claim Mastery"] = "Tự Nhận Thưởng Tinh Thông Boss",
    ["Tự Động Nhận Thưởng Mastery"] = "Tự Nhận Thưởng Tinh Thông Boss",
    ["Claims Boss Mastery rewards as soon as they unlock"] = "Tự nhận thưởng Tinh Thông Boss ngay khi mở khóa",
    ["Lab Banners"] = "Biểu Ngữ Phòng Lab",
    ["Only trade and steal for these banners (empty = all)"] = "Chỉ đổi và cướp các biểu ngữ này (trống = tất cả)",
    ["Auto Lab Trade-In"] = "Tự Đổi Đồ Phòng Thí Nghiệm",
    ["Auto Reroll Lab Recipe"] = "Tự Đổi Công Thức Phòng Lab",
    ["Auto Place Lab Reward Eggs"] = "Tự Đặt Trứng Thưởng Lab",
    ["Places the reward eggs from Lab trades"] = "Tự động đặt trứng thưởng nhận từ đổi đồ phòng lab",
    ["Auto Buy Scramble Shop"] = "Tự Mua Shop Dr. Scramble",
    ["Buy the picked items with Samples"] = "Dùng Mẫu Vật (Samples) mua các vật phẩm đã chọn",
    ["Scramble Shop Items"] = "Vật Phẩm Cửa Hàng Scramble",
    ["Keep Samples"] = "Giữ Lại Mẫu Vật Tối Thiểu",
    ["Never spend below this many Samples"] = "Không bao giờ tiêu hao dưới mức mẫu vật này",
    ["Auto Use Scrambled"] = "Tự Dùng Thuốc Biến Đổi Scrambled",
    ["Turn it on to start applying Scrambled"] = "Bật lên để bắt đầu áp dụng thuốc Scrambled",
    ["Auto Buy Scrambled"] = "Tự Mua Thêm Scrambled Khi Hết",
    ["Buy another Scrambled from the event shop when you run out"] = "Tự mua thêm Scrambled từ shop sự kiện khi dùng hết",
    ["Mutation Min Rarity"] = "Độ Hiếm Đột Biến Min",
    ["Only eggs of this rarity and above are used"] = "Chỉ dùng trứng từ độ hiếm này trở lên",
    ["Min Mutation Value"] = "Giá Trị Đột Biến Min",
    ["Mutation Priority"] = "Ưu Tiên Đột Biến",
    ["Which egg gets the consumable first"] = "Trứng nào được ưu tiên dùng thuốc trước",
    ["Mutation Target Eggs"] = "Mục Tiêu Trứng Đột Biến",
    ["Only use the consumable on these eggs (empty = all)"] = "Chỉ dùng thuốc lên các trứng này (trống = tất cả)",
    ["Need a Scrambled consumable"] = "Cần vật phẩm Scrambled",
    ["Buy Scrambled from the event shop"] = "Mua Scrambled từ shop sự kiện",
    ["Unstable DNA"] = "DNA Không Ổn Định (Unstable DNA)",

    -- Butterfly Bloom
    ["Auto Butterfly Bloom"] = "Tự Động Bắt Bướm",
    ["Tự động Butterfly Bloom"] = "Tự Động Bắt Bướm",
    ["Catch Mode"] = "Chế Độ Bắt",
    ["Catch Priority"] = "Ưu Tiên Bắt",
    ["Only for Chase mode"] = "Chỉ dùng cho chế độ Đuổi theo",
    ["Catch Butterflies"] = "Chọn Bướm Cần Bắt",
    ["Radiant Butterfly"] = "Bướm Rực Rỡ",
    ["Amethyst Butterfly"] = "Bướm Thạch Anh Tím",
    ["Sapphire Butterfly"] = "Bướm Lam Ngọc (Sapphire)",
    ["Emerald Butterfly"] = "Bướm Lục Bảo (Emerald)",
    ["Tween Speed"] = "Tốc Độ Bay (Tween)",
    ["Tốc Độ Bay (Tween)"] = "Tốc Độ Bay (Tween)",
    ["Auto Trade Up"] = "Tự Nâng Cấp Bướm",
    ["Trade Up Tiers"] = "Bậc Nâng Cấp",
    ["Smart Trade For Essence"] = "Đổi Bướm Lấy Tinh Chất Thông Minh",
    ["Going to the middle of the bloom"] = "Đang đi tới trung tâm khu bướm nở",

    -- Essence
    ["Auto Craft Essence"] = "Tự Chế Tạo Tinh Chất",
    ["Auto Use Enchanted Essence"] = "Tự Dùng Tinh Chất Phù Phép",
    ["Essence Min Rarity"] = "Độ Hiếm Nhận Tinh Chất Min",
    ["Essence Độ Hiếm Tối Thiểu"] = "Độ Hiếm Nhận Tinh Chất Min",
    ["Only eggs of this rarity and above get the essence"] = "Chỉ trứng đạt độ hiếm này trở lên mới nhận tinh chất",
    ["Essence Min Value"] = "Giá Trị Nhận Tinh Chất Min",
    ["Essence Min Giá trị"] = "Giá Trị Nhận Tinh Chất Min",
    ["Skip eggs worth less than this (0 = off)"] = "Bỏ qua trứng giá trị nhỏ hơn mức này (0 = tắt)",
    ["Essence Target Eggs"] = "Mục Tiêu Trứng Nhận Tinh Chất",
    ["Essence Target Trứng"] = "Mục Tiêu Trứng Nhận Tinh Chất",
    ["Only use the essence on these eggs (empty = all)"] = "Chỉ dùng tinh chất lên trứng này (trống = tất cả)",
    ["Essence Priority"] = "Ưu Tiên Dùng Tinh Chất",
    ["Which egg gets the essence first"] = "Trứng nào được ưu tiên nhận tinh chất trước",
    ["Essence Skip Enchanted Eggs"] = "Bỏ Qua Trứng Đã Phù Phép",
    ["Essence Skip Enchanted Trứng"] = "Bỏ Qua Trứng Đã Phù Phép",
    ["Skip eggs that already got Enchanted, other mutations still get the essence"] = "Bỏ qua trứng đã phù phép, đột biến khác vẫn nhận tinh chất",

    -- Chase Settings
    ["Chase Settings"] = "Cài Đặt Đuổi Đánh",
    ["Hit Tween Speed"] = "Tốc Độ Bay Đánh",
    ["Hit Max Speed"] = "Tốc Độ Đánh Tối Đa",
    ["Hit Lead"] = "Đón Đầu Đòn Đánh (Hit Lead)",
    ["Stand further ahead of the target (i.e. or closer to them)"] = "Đứng đón đầu mục tiêu xa hơn (hoặc áp sát gần hơn)",
    ["Hit Sweep"] = "Góc Quét Đòn Đánh (Hit Sweep)",
    ["How far you swipe back and forth in front of the target"] = "Khoảng cách vung vũ khí quét qua lại trước mục tiêu",
    ["Add/Remove Hits On Quick Bar 2"] = "Thêm/Bỏ Nút Đánh Vào Quick Bar 2",
    ["Pin or unpin the hit toggles on Quick Bar 2"] = "Ghim hoặc bỏ ghim các nút đánh trên Quick Bar 2",
    ["Auto Hit Nearest Player"] = "Tự Đánh Người Gần Nhất",
    ["Auto Hit Egg Holders"] = "Tự Đánh Người Đang Bê Trứng",
    ["Auto Hit Specific Player"] = "Tự Đánh Người Chỉ Định",
    ["Hit Player"] = "Chọn Người Cần Đánh",
    ["Hit Aura"] = "Vòng Đánh Tự Động (Hit Aura)",
    ["Instant Prompts"] = "Tương Tác Phím Nhanh (Instant E)",

    -- Movement / Character
    ["Movement"] = "Di Chuyển",
    ["Character"] = "Nhân Vật",
    ["Speed Boost"] = "Tăng Tốc Chạy",
    ["Boost Speed"] = "Tốc Độ Tăng Tốc",
    ["Infinite Jump"] = "Nhảy Vô Hạn",
    ["Invisibility"] = "Tàng Hình (Invisibility)",
    ["Makes you invisible to other players"] = "Làm bạn vô hình trước người chơi khác",
    ["Anti Ragdoll"] = "Chống Ngã (Anti Ragdoll)",
    ["Anti Trap"] = "Chống Bẫy (Anti Trap)",
    ["Traps from other players cannot catch you"] = "Bẫy của người khác không thể bắt được bạn",
    ["Combat"] = "Chiến Đấu",

    -- ESP
    ["ESP"] = "Định Vị (ESP)",
    ["ESP Eggs"] = "ESP Trứng",
    ["ESP Fixed Size"] = "Cỡ ESP Cố Định",
    ["ESP Own Base Eggs"] = "Hiện Trứng Căn Cứ Mình",
    ["Also show the eggs placed in your own base"] = "Hiển thị cả trứng đã đặt tại căn cứ của bạn",
    ["ESP Min Rarity"] = "Độ Hiếm ESP Min",
    ["Show eggs of the chosen rarity and every rarity above it"] = "Hiện trứng từ độ hiếm đã chọn trở lên",
    ["ESP Show Info"] = "Hiện Thông Tin ESP",
    ["Min ESP Value"] = "Giá Trị ESP Min",
    ["ESP Egg Size"] = "Cỡ ESP Trứng",
    ["ESP Guards"] = "ESP Vệ Sĩ",
    ["ESP Guard Size"] = "Cỡ ESP Vệ Sĩ",
    ["ESP Lost Parts"] = "ESP Phụ Tùng Rơi",
    ["ESP Players"] = "ESP Người Chơi",
    ["ESP Player Info"] = "Thông Tin ESP Người Chơi",
    ["ESP Player Size"] = "Cỡ ESP Người Chơi",

    -- Predictor
    ["Predictor"] = "Dự Đoán",
    ["Egg Predictor"] = "Dự Đoán Trứng",
    ["Lab Predictor"] = "Dự Đoán Phòng Lab",
    ["Fuse Predictor"] = "Dự Đoán Dung Hợp",
    ["Search eggs..."] = "Tìm kiếm trứng...",
    ["FLY TO EGG"] = "BAY ĐẾN TRỨNG",
    ["Biohazard Pets"] = "Pet Phóng Xạ (Biohazard)",
    ["CURRENT RECIPE"] = "CÔNG THỨC HIỆN TẠI",
    ["REWARD ODDS - BIOHAZARD PETS"] = "TỈ LỆ THƯỞNG - PET PHÓNG XẠ",
    ["Chase pet"] = "Đuổi bắt pet",
    ["Machine is empty"] = "Máy đang trống",
    ["Load 3 pets of the same species to see the result odds"] = "Đặt 3 pet cùng loài vào máy để xem tỉ lệ kết quả",
    ["Sort By"] = "Sắp Xếp Theo",
    ["Preview Card"] = "Thẻ Xem Trước",
    ["Discord Webhook"] = "Cài Đặt Webhook Discord",

    -- Progression
    ["Auto Progression"] = "Tự Động Tiến Trình",
    ["Auto Buy Trail"] = "Tự Mua Vệt Sáng (Trail)",
    ["Automatically buy available trails when affordable"] = "Tự động mua vệt sáng có sẵn khi đủ tiền",
    ["Auto Upgrade Base"] = "Tự Nâng Cấp Căn Cứ",
    ["Automatically upgrade base when money is available"] = "Tự động nâng cấp căn cứ khi đủ tiền",
    ["Auto Upgrade Treadmill"] = "Tự Nâng Cấp Máy Tập",
    ["Automatically upgrade treadmill when money is available"] = "Tự động nâng cấp máy tập khi đủ tiền",
    ["Auto Claim"] = "Tự Nhận Thưởng",
    ["Claim offline money & index rewards"] = "Nhận tiền tích lũy offline & thưởng sách pet",
    ["Auto Claim Index"] = "Tự Nhận Thưởng Sách Pet",
    ["Claim index rewards as soon as they unlock"] = "Tự động nhận thưởng sách ngay khi mở khóa",

    -- Server
    ["Server Hop Mode"] = "Chế Độ Đổi Server",
    ["Server Hop"] = "Đổi Server",
    ["Job ID"] = "Mã Phòng (Job ID)",
    ["Paste a server Job ID..."] = "Dán mã Job ID của server...",
    ["Join Job ID"] = "Vào Bằng Job ID",
    ["Copy Current Job ID"] = "Chép Job ID Hiện Tại",
    ["Rejoin Server"] = "Vào Lại Server",
    ["Auto Rejoin When Disconnect"] = "Tự Kết Nối Lại Khi Mất Mạng",
    ["Joins new servers to find eggs that match the filters below"] = "Tự đổi server để tìm trứng khớp bộ lọc bên dưới",
    ["Turn on Auto Hop to start hunting"] = "Bật Tự Đổi Server để bắt đầu săn trứng",
    ["Hop Mode"] = "Chế Độ Đổi Server",
    ["Rarity To Wait For"] = "Độ Hiếm Cần Giữ Chân",
    ["For After A Rare Spawns this rarity or higher"] = "Chờ nếu xuất hiện trứng từ độ hiếm này trở lên",
    ["Sync With Auto Steal Filters"] = "Đồng Bộ Bộ Lọc Cướp",
    ["Changing a filter here also changes it in Auto Steal, and back"] = "Thay đổi bộ lọc tại đây sẽ đồng bộ với mục Tự Động Cướp",
    ["Find eggs of the chosen rarity and every rarity above it"] = "Tìm trứng thuộc độ hiếm đã chọn và cao hơn",
    ["Min Value To Find"] = "Giá Trị Trứng Min Cần Tìm",
    ["Skip eggs worth less than this. Drag or type 350k, 50m, 10b"] = "Bỏ qua trứng giá nhỏ hơn mức này. Kéo hoặc nhập 350k, 50m, 10b",
    ["First Hop Delay"] = "Độ Trễ Lần Đổi Server Đầu",
    ["Wait after the script loads before the first hop"] = "Chờ sau khi nạp script hoàn tất trước khi đổi server",
    ["Webhook URL"] = "Đường Dẫn Webhook",
    ["Ping @everyone"] = "Tag @everyone",
    ["Notify Stolen Eggs"] = "Báo Cáo Cướp Trứng",
    ["Post every egg you bring home"] = "Gửi thông báo mỗi quả trứng mang về thành công",

    -- Performance / Utility
    ["Performance"] = "Hiệu Năng",
    ["Utility"] = "Tiện Ích",
    ["FPS Cap"] = "Giới Hạn FPS",
    ["Optimizer"] = "Tối Ưu Hóa (Giảm Lag)",
    ["Strip shadows, textures and effects for the highest FPS"] = "Xóa bóng, bề mặt và hiệu ứng để đạt FPS tối đa",
    ["FPS and Ping"] = "Hiện FPS & Ping",
    ["FPS and Ping Size"] = "Kích Cỡ FPS & Ping",
    ["Disable 3D Render"] = "Tắt Đồ Họa 3D",
    ["Farm HUD"] = "Bảng Cày Cuốc (Farm HUD)",
    ["Drag any panel to place it where you like"] = "Kéo bất kỳ bảng nào đến vị trí bạn muốn",
    ["Anti AFK"] = "Chống Treo Máy (Anti AFK)",
    ["Auto Load Script"] = "Tự Động Nạp Script",

    -- Egg Finder
    ["Egg Finder"] = "Dò Tìm Trứng",
    ["Quick Bar 1"] = "Thanh Phím Nhanh 1",
    ["Quick Bar 2"] = "Thanh Phím Nhanh 2",

    -- Wisp
    ["Auto Wisp"] = "Tự Động Nhặt Wisp",
    ["Auto Banjo Cricket"] = "Tự Động Bắt Dế Banjo",

    -- Popup cảnh báo Instant Steal V2
    ["Cuớp Siêu Tốc (Instant Steal) V2 may not work well below 40 FPS or above 200 ms ping."] = "Cướp Siêu Tốc (Instant Steal) V2 có thể hoạt động không tốt dưới 40 FPS hoặc ping trên 200 ms.",
    ["Your FPS"] = "FPS của bạn",
    ["Your Ping"] = "Ping của bạn",
    ["ms"] = "ms",

    -- Đếm số
    ["selected"] = "đã chọn"
}

-- =========================================================
-- HÀM DỊCH (EXACT MATCH TRƯỚC, FALLBACK MAP_VI)
-- =========================================================
local sortedKeys = {}
for k in pairs(MAP_VI) do table.insert(sortedKeys, k) end
table.sort(sortedKeys, function(a,b) return #a > #b end)

local escapePattern = function(s)
    return (s:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

local translateCache = {}

-- Bỏ qua text động (số, tiền, %, thời gian)
local SKIP_PATTERNS = {
    "^[%d%p%s]+$",
    "^%$[%d%.]+[KMBT]?$",
    "^%d+[KMBT]?$",
    "^[+%-]%$[%d%.]+[KMBT]?$",
    "^%d+%.%d+s$",
    "^%d+/%d+$",
}

local function shouldSkip(text)
    for _, pat in ipairs(SKIP_PATTERNS) do
        if text:match(pat) then return true end
    end
    return false
end

local function translateText(text)
    if type(text) ~= "string" or text == "" then return text end
    
    -- Cache hit
    local cached = translateCache[text]
    if cached ~= nil then return cached end
    
    -- ƯU TIÊN 1: EXACT MATCH (khớp chính xác toàn bộ text)
    local exact = EXACT_MATCH_VI[text]
    if exact then
        translateCache[text] = exact
        return exact
    end
    
    -- ƯU TIÊN 2: MAP_VI EXACT (khớp chính xác)
    local mapped = MAP_VI[text]
    if mapped then
        translateCache[text] = mapped
        return mapped
    end
    
    -- Skip text động
    if shouldSkip(text) then
        translateCache[text] = text
        return text
    end
    
    -- ƯU TIÊN 3: FALLBACK - thay thế cụm từ trong câu dài
    local out = text
    for _, en in ipairs(sortedKeys) do
        local vi = MAP_VI[en]
        if vi ~= en then
            local pat = "%f[%w]" .. escapePattern(en) .. "%f[%W]"
            out = out:gsub(pat, vi)
        end
    end
    
    translateCache[text] = out
    return out
end

-- =========================================================
-- POLLING ENGINE (KHÔNG HOOK EVENT - CHỐNG LAG)
-- =========================================================
local translating = false
local trackedObjects = {}

local IGNORE_GUI_NAMES = {
    ["Chat"] = true, ["Backpack"] = true, ["PlayerList"] = true,
    ["BubbleChat"] = true, ["TouchGui"] = true, ["TouchControlFrame"] = true,
    ["ControlFrame"] = true, ["Topbar"] = true, ["StarterGui"] = true,
    ["LangSelector"] = true,
}

local function registerObject(obj)
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end
    if obj:GetAttribute("ChilliTracked") then return end
    obj:SetAttribute("ChilliTracked", true)
    
    table.insert(trackedObjects, {
        obj = obj,
        lastText = nil,
    })
end

local function scanGui(gui)
    if not gui:IsA("ScreenGui") then return end
    if IGNORE_GUI_NAMES[gui.Name] then return end
    
    local descendants = gui:GetDescendants()
    for i, d in ipairs(descendants) do
        registerObject(d)
        if i % 30 == 0 then task.wait() end
    end
end

local POLL_INTERVAL = 0.5

local function pollingLoop()
    while true do
        task.wait(POLL_INTERVAL)
        
        if translating then continue end
        translating = true
        
        for i = #trackedObjects, 1, -1 do
            local entry = trackedObjects[i]
            local obj = entry.obj
            
            if not obj or not obj.Parent then
                table.remove(trackedObjects, i)
                continue
            end
            
            local ok, cur = pcall(function() return obj.Text end)
            if ok and type(cur) == "string" and cur ~= "" and cur ~= entry.lastText then
                local new = translateText(cur)
                if new ~= cur then
                    pcall(function() obj.Text = new end)
                    entry.lastText = new
                else
                    entry.lastText = cur
                end
            end
        end
        
        translating = false
    end
end

-- =========================================================
-- WATCHER
-- =========================================================
local function startWatching()
    task.wait(3)
    
    local targets = {
        CoreGui,
        Players.LocalPlayer:WaitForChild("PlayerGui")
    }
    
    for _, container in ipairs(targets) do
        if container then
            for _, gui in ipairs(container:GetChildren()) do
                if gui:IsA("ScreenGui") and not IGNORE_GUI_NAMES[gui.Name] then
                    task.spawn(function() scanGui(gui) end)
                end
            end
            
            container.DescendantAdded:Connect(function(d)
                if d:IsA("ScreenGui") and not IGNORE_GUI_NAMES[d.Name] then
                    task.defer(function() scanGui(d) end)
                elseif d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                    task.defer(function() registerObject(d) end)
                end
            end)
        end
    end
end

-- =========================================================
-- HÀM TẢI SCRIPT
-- =========================================================
local function fetchScript(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and type(res) == "string" and #res > 0 then return res end
    
    for _, name in ipairs({"request","http_request","syn_request"}) do
        local fn = _G[name]
        if type(fn) == "function" then
            local ok2, r = pcall(fn, {Url = url, Method = "GET"})
            if ok2 and r and r.Body and #r.Body > 0 then
                return r.Body
            end
        end
    end
    return nil
end

-- =========================================================
-- UI CHỌN NGÔN NGỮ (PREMIUM GLASSMORPHISM DESIGN)
-- =========================================================
local gui = Instance.new("ScreenGui")
gui.Name = "LangSelector"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
do
    local ok = pcall(function() gui.Parent = CoreGui end)
    if not ok or not gui.Parent then
        gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
end

-- Background mờ toàn màn hình
local backdrop = Instance.new("Frame", gui)
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backdrop.BackgroundTransparency = 1
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 1

-- Khung chính
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 440, 0, 300)
frame.Position = UDim2.new(0.5, -220, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
frame.BorderSizePixel = 0
frame.Active = true
frame.ZIndex = 2

local frameGradient = Instance.new("UIGradient", frame)
frameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30)),
})
frameGradient.Rotation = 135

local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 18)

local glowStroke = Instance.new("UIStroke", frame)
glowStroke.Color = Color3.fromRGB(255, 80, 80)
glowStroke.Thickness = 1.5
glowStroke.Transparency = 0.3

-- Shadow layer
local shadow = Instance.new("Frame", gui)
shadow.Size = frame.Size
shadow.Position = frame.Position
shadow.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
shadow.BackgroundTransparency = 0.85
shadow.BorderSizePixel = 0
shadow.ZIndex = 1
Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 20)

-- Tiêu đề
local titleContainer = Instance.new("Frame", frame)
titleContainer.Size = UDim2.new(1, 0, 0, 70)
titleContainer.Position = UDim2.new(0, 0, 0, 15)
titleContainer.BackgroundTransparency = 1

local titleText = Instance.new("TextLabel", titleContainer)
titleText.Size = UDim2.new(1, 0, 0, 30)
titleText.Position = UDim2.new(0, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🌐 CHILLI HUB"
titleText.TextColor3 = Color3.fromRGB(255, 100, 100)
titleText.Font = Enum.Font.GothamBlack
titleText.TextSize = 22
titleText.TextStrokeTransparency = 0.5
titleText.TextStrokeColor3 = Color3.fromRGB(80, 0, 0)

local subtitleText = Instance.new("TextLabel", titleContainer)
subtitleText.Size = UDim2.new(1, 0, 0, 20)
subtitleText.Position = UDim2.new(0, 0, 0, 32)
subtitleText.BackgroundTransparency = 1
subtitleText.Text = "Select Your Language"
subtitleText.TextColor3 = Color3.fromRGB(180, 180, 200)
subtitleText.Font = Enum.Font.GothamMedium
subtitleText.TextSize = 13

-- Đường phân cách
local divider = Instance.new("Frame", frame)
divider.Size = UDim2.new(1, -60, 0, 1)
divider.Position = UDim2.new(0, 30, 0, 90)
divider.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
divider.BorderSizePixel = 0
divider.BackgroundTransparency = 0.5
local dividerGradient = Instance.new("UIGradient", divider)
dividerGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.3),
    NumberSequenceKeypoint.new(1, 1),
})

-- Holder nút
local holder = Instance.new("Frame", frame)
holder.Size = UDim2.new(1, -60, 0, 90)
holder.Position = UDim2.new(0, 30, 0, 115)
holder.BackgroundTransparency = 1
local lay = Instance.new("UIListLayout", holder)
lay.FillDirection = Enum.FillDirection.Horizontal
lay.Padding = UDim.new(0, 15)
lay.HorizontalAlignment = Enum.HorizontalAlignment.Center
lay.VerticalAlignment = Enum.VerticalAlignment.Center

-- Hàm tạo nút
local function makeLangBtn(flagEmoji, langName, subName, color1, color2, onClick)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, -8, 1, 0)
    btn.BackgroundColor3 = color1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = holder

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

    local btnGradient = Instance.new("UIGradient", btn)
    btnGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2),
    })
    btnGradient.Rotation = 135

    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(255, 255, 255)
    btnStroke.Thickness = 1
    btnStroke.Transparency = 0.8

    local flag = Instance.new("TextLabel", btn)
    flag.Size = UDim2.new(1, 0, 0, 30)
    flag.Position = UDim2.new(0, 0, 0, 12)
    flag.BackgroundTransparency = 1
    flag.Text = flagEmoji
    flag.Font = Enum.Font.GothamBold
    flag.TextSize = 26
    flag.TextColor3 = Color3.fromRGB(255, 255, 255)

    local nameLabel = Instance.new("TextLabel", btn)
    nameLabel.Size = UDim2.new(1, 0, 0, 22)
    nameLabel.Position = UDim2.new(0, 0, 0, 46)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = langName
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 15
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0.5

    local subLabel = Instance.new("TextLabel", btn)
    subLabel.Size = UDim2.new(1, 0, 0, 16)
    subLabel.Position = UDim2.new(0, 0, 0, 68)
    subLabel.BackgroundTransparency = 1
    subLabel.Text = subName
    subLabel.Font = Enum.Font.Gotham
    subLabel.TextSize = 11
    subLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    subLabel.TextTransparency = 0.2

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(0.5, -4, 1.05, 0)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.3, Thickness = 1.5}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(0.5, -8, 1, 0)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.8, Thickness = 1}):Play()
    end)

    -- Click effect
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.5, -12, 0.95, 0)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {Size = UDim2.new(0.5, -4, 1.05, 0)}):Play()
    end)
    btn.MouseButton1Click:Connect(onClick)

    return btn
end

-- Trạng thái
local status = Instance.new("TextLabel", frame)
status.Size = UDim2.new(1, -60, 0, 24)
status.Position = UDim2.new(0, 30, 1, -45)
status.BackgroundTransparency = 1
status.Text = "Chọn ngôn ngữ để bắt đầu • Choose a language to begin"
status.TextColor3 = Color3.fromRGB(150, 150, 170)
status.Font = Enum.Font.Gotham
status.TextSize = 12

-- Kéo thả
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        shadow.Position = frame.Position
    end
end)

-- Nút đóng
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 12)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 20, 20)}):Play()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 120, 120)}):Play()
end)
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    TweenService:Create(shadow, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    task.wait(0.2)
    gui:Destroy()
end)

-- Hiệu ứng xuất hiện
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(0, 0, 0, 0)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(backdrop, TweenInfo.new(0.3), {BackgroundTransparency = 0.6}):Play()
TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 440, 0, 300),
    Position = UDim2.new(0.5, -220, 0.5, -150)
}):Play()
TweenService:Create(shadow, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 440, 0, 300),
    Position = UDim2.new(0.5, -220, 0.5, -150)
}):Play()

-- Pulse glow
task.spawn(function()
    while frame.Parent do
        TweenService:Create(glowStroke, TweenInfo.new(1.5), {Transparency = 0.6}):Play()
        task.wait(1.5)
        TweenService:Create(glowStroke, TweenInfo.new(1.5), {Transparency = 0.2}):Play()
        task.wait(1.5)
    end
end)

-- =========================================================
-- CHẠY
-- =========================================================
local loading = false
local function run(lang)
    if loading then return end
    loading = true
    
    status.Text = (lang == "vi") and "⏳ Đang tải script..." or "⏳ Loading script..."
    
    for _, child in ipairs(holder:GetChildren()) do
        if child:IsA("TextButton") then
            TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 0.7}):Play()
        end
    end
    
    task.spawn(function()
        local src = fetchScript(SCRIPT_URL)
        if not src then
            status.Text = (lang == "vi") and "❌ Không tải được script!" or "❌ Failed to fetch script!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            loading = false
            return
        end
        
        status.Text = (lang == "vi") and "▶️ Đang khởi chạy..." or "▶️ Launching..."
        status.TextColor3 = Color3.fromRGB(100, 255, 150)
        task.wait(0.4)
        
        TweenService:Create(backdrop, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        TweenService:Create(shadow, TweenInfo.new(0.25), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        task.wait(0.3)
        gui:Destroy()
        
        local loader = loadstring or load
        local fn, err = loader(src)
        if not fn then
            warn("[LangSel] loadstring error: " .. tostring(err))
            return
        end
        
        task.spawn(fn)
        
        if lang == "vi" then
            task.spawn(startWatching)
            task.spawn(pollingLoop)
        end
    end)
end

-- Tạo 2 nút ngôn ngữ
makeLangBtn(
    "🇻🇳",
    "Tiếng Việt",
    "Vietnamese",
    Color3.fromRGB(180, 30, 30),
    Color3.fromRGB(220, 60, 60),
    function() run("vi") end
)

makeLangBtn(
    "🇺🇸",
    "English",
    "Tiếng Anh",
    Color3.fromRGB(30, 70, 180),
    Color3.fromRGB(60, 120, 220),
    function() run("en") end
)
