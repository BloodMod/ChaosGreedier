@ECHO off
TITLE 헌영방송 실행기
COLOR %cc%
ECHO %cc%
start rooms\건들지마세요\패치노트\패치노트.txt
explorer "http://fav.afreecatv.com:8057/afreeca/favorite_api.php?szWork=ADD&nAspCode=0&szBjld=iwt2hw&favorite=iwt2hw&from=app"
:First
cls
ECHO http://afreeca.com/iwt2hw
ECHO BJ헌영(iwt2hw) 직접 제작한 간단 유틸리티 프로그램입니다.
ECHO 배포 및 무단수정 절대 금지 합니다.
ECHO 실행기 기능 추가 및 기타 건의는 카카오톡(iwt2hw)
ECHO.
ECHO     
ECHO        
ECHO       1) 헌영 소셜 및 SNS 바로가기    2) 카오스 그리디어 다운＆설정  
ECHO        
ECHO        
ECHO       3) 노말 아이작 다운＆설정       4) [HOT]진행중인 퀵뷰 이벤트   
ECHO        
ECHO        
ECHO       5) 각종 커뮤니티 사이트         6) 타이머 및 유틸리티          
ECHO        
ECHO        
ECHO       7) 모드 최신 버전 체크          8) 방송 브금(47GB 다운로드)    
ECHO        
ECHO        
ECHO       9) 팀뷰어 원격 요청             10) 방송 톡방 가입             
ECHO        
ECHO     
echo.
echo.
set /p hy=원하는 선택을 입력후 엔터키를 눌러주세요. 원하는 항목이 없을경우 0을 입력시 초기화면으로 돌아갑니다.
:hy
:hy
if /i "%hy%"=="1" goto 헌영 소셜 및 SNS 바로가기
if /i "%hy%"=="2" goto 에픽빔 적용 및 제거
if /i "%hy%"=="3" goto 노말 아이작 다운＆설정
if /i "%hy%"=="4" goto 퀵뷰이벤트
if /i "%hy%"=="5" goto 각종 커뮤니티 사이트
if /i "%hy%"=="6" goto 타이머 및 유틸리티
if /i "%hy%"=="7" goto 히오스
if /i "%hy%"=="8" goto 브금
if /i "%hy%"=="9" goto 팀뷰어
if /i "%hy%"=="10" goto 톡방
if /i "%hy%"=="1115" goto 1115
if /i "%hy%"=="컴복" goto 컴복
if /i "%hy%"=="노복" goto 노복
cls

:노말 아이작 다운＆설정
cls
ECHO http://afreeca.com/iwt2hw
ECHO BJ헌영(iwt2hw) 직접 제작한 간단 유틸리티 프로그램입니다.
ECHO 배포 및 무단수정 절대 금지 합니다.
ECHO 실행기 기능 추가 및 기타 건의는 카카오톡(iwt2hw)
ECHO.
ECHO     
ECHO        
ECHO       1) 노말 아이작 게임 다운        2) 노말 아이작 세이브 다운     
ECHO        
ECHO        
ECHO       3) 스파이더 모드 다운           4) 스파이더 모드(리믹스) 다운  
ECHO        
ECHO        
ECHO       5) 준비중입니다...              6) 준비중입니다...             
ECHO        
ECHO        
ECHO       7) 준비중입니다...              8) 준비중입니다...             
ECHO        
ECHO        
ECHO       9) 준비중입니다...              10) 준비중입니다...            
ECHO        
ECHO     
echo.
echo.
set /p 노말 아이작 다운＆설정=원하는 선택을 입력후 엔터키를 눌러주세요. 원하는 항목이 없을경우 0을 입력시 초기화면으로 돌아갑니다.
if /i "%노말 아이작 다운＆설정%"=="1" goto 노말다운
if /i "%노말 아이작 다운＆설정%"=="2" goto 노말세이브
if /i "%노말 아이작 다운＆설정%"=="3" goto 스파이더
if /i "%노말 아이작 다운＆설정%"=="4" goto 리믹스
cls

:헌영 소셜 및 SNS 바로가기
cls
ECHO http://afreeca.com/iwt2hw
ECHO BJ헌영(iwt2hw) 직접 제작한 간단 유틸리티 프로그램입니다.
ECHO 배포 및 무단수정 절대 금지 합니다.
ECHO 실행기 기능 추가 및 기타 건의는 카카오톡(iwt2hw)
ECHO.
ECHO     
ECHO        
ECHO       1) 헌영 방송국(본캐) 바로 가기  2) 헌영 방송국(부캐) 바로 가기 
ECHO        
ECHO        
ECHO       3) 헌영 유튜브 바로 가기        4) 헌영 스팀 친추하기          
ECHO        
ECHO        
ECHO       5) 준비중입니다...              6) 준비중입니다...             
ECHO        
ECHO        
ECHO       7) 준비중입니다...              8) 준비중입니다...             
ECHO        
ECHO        
ECHO       9) 준비중입니다...              10) 준비중입니다...            
ECHO        
ECHO     
echo.
echo.
set /p 헌영 소셜 및 SNS 바로가기=원하는 선택을 입력후 엔터키를 눌러주세요. 원하는 항목이 없을경우 0을 입력시 초기화면으로 돌아갑니다.
if /i "%헌영 소셜 및 SNS 바로가기%"=="0" goto 0
if /i "%헌영 소셜 및 SNS 바로가기%"=="1" goto 본캐방송국
if /i "%헌영 소셜 및 SNS 바로가기%"=="2" goto 부캐방송국
if /i "%헌영 소셜 및 SNS 바로가기%"=="3" goto 유튜브
if /i "%헌영 소셜 및 SNS 바로가기%"=="4" goto 스팀친추
cls

:에픽빔 적용 및 제거
cls
ECHO http://afreeca.com/iwt2hw
ECHO BJ헌영(iwt2hw) 직접 제작한 간단 유틸리티 프로그램입니다.
ECHO 배포 및 무단수정 절대 금지 합니다.
ECHO 실행기 기능 추가 및 기타 건의는 카카오톡(iwt2hw)
ECHO.
ECHO     
ECHO        
ECHO       1) 에픽빔 적용                  2) 에픽빔 제거                 
ECHO        
ECHO        
ECHO       3) 라이트 모드 적용             4) 라이트 모드 제거            
ECHO        
ECHO        
ECHO       5) 아이템 스킨 이미지 적용      6) 애프터버스+ 다운            
ECHO        
ECHO        
ECHO       7) 카오스 그리디어 모드 다운    8) 모든 클리어 세이브 다운     
ECHO        
ECHO        
ECHO       9) 모드 적용법＆오류 해결법     10) Windows 계정명 변경        
ECHO        
ECHO     
echo.
echo.
set /p 에픽빔 적용 및 제거=원하는 선택을 입력후 엔터키를 눌러주세요. 원하는 항목이 없을경우 0을 입력시 초기화면으로 돌아갑니다.
if /i "%에픽빔 적용 및 제거%"=="1" goto 에픽빔적용
if /i "%에픽빔 적용 및 제거%"=="2" goto 에픽빔제거
if /i "%에픽빔 적용 및 제거%"=="3" goto 라이트적용
if /i "%에픽빔 적용 및 제거%"=="4" goto 라이트제거
if /i "%에픽빔 적용 및 제거%"=="5" goto 아이템적용
if /i "%에픽빔 적용 및 제거%"=="6" goto 애프터다운
if /i "%에픽빔 적용 및 제거%"=="7" goto 카오스다운
if /i "%에픽빔 적용 및 제거%"=="8" goto 세이브다운
if /i "%에픽빔 적용 및 제거%"=="9" goto 모드적용오류해결
if /i "%에픽빔 적용 및 제거%"=="10" goto 계정변경
cls

:각종 커뮤니티 사이트
cls
ECHO http://afreeca.com/iwt2hw
ECHO BJ헌영(iwt2hw) 직접 제작한 간단 유틸리티 프로그램입니다.
ECHO 배포 및 무단수정 절대 금지 합니다.
ECHO 실행기 기능 추가 및 기타 건의는 카카오톡(iwt2hw)
ECHO.
ECHO     
ECHO        
ECHO       1) 일간 베스트                  2) 오늘의 유머                 
ECHO        
ECHO        
ECHO       3) 인터넷 방송 갤러리           4) 개드립                      
ECHO        
ECHO        
ECHO       5) 포모스                       6) 와이고수                    
ECHO        
ECHO        
ECHO       7) 인벤                         8) 웃긴 대학                   
ECHO        
ECHO        
ECHO       9) 던파 조선                    10) 루리웹                     
ECHO        
ECHO     
echo.
echo.
set /p 각종 커뮤니티 사이트=원하는 선택을 입력후 엔터키를 눌러주세요. 원하는 항목이 없을경우 0을 입력시 초기화면으로 돌아갑니다.
if /i "%각종 커뮤니티 사이트%"=="1" goto 일간베스트
if /i "%각종 커뮤니티 사이트%"=="2" goto 오늘의유머
if /i "%각종 커뮤니티 사이트%"=="3" goto 인터넷방송갤러리
if /i "%각종 커뮤니티 사이트%"=="4" goto 개드립
if /i "%각종 커뮤니티 사이트%"=="5" goto 포모스
if /i "%각종 커뮤니티 사이트%"=="6" goto 와이고수
if /i "%각종 커뮤니티 사이트%"=="7" goto 인벤
if /i "%각종 커뮤니티 사이트%"=="8" goto 웃긴대학
if /i "%각종 커뮤니티 사이트%"=="9" goto 던파조선
if /i "%각종 커뮤니티 사이트%"=="10" goto 루리웹
cls

:타이머 및 유틸리티
cls
ECHO http://afreeca.com/iwt2hw
ECHO BJ헌영(iwt2hw) 직접 제작한 간단 유틸리티 프로그램입니다.
ECHO 배포 및 무단수정 절대 금지 합니다.
ECHO 실행기 기능 추가 및 기타 건의는 카카오톡(iwt2hw)
ECHO.
ECHO     
ECHO        
ECHO       1) 타이머(Xntimer)              2) 컴퓨터 속도 향상            
ECHO        
ECHO        
ECHO       3) PC 카카오톡 다운             4) 준비중입니다...             
ECHO        
ECHO        
ECHO       5) 준비중입니다...              6) 준비중입니다...             
ECHO        
ECHO        
ECHO       7) 준비중입니다...              8) 준비중입니다...             
ECHO        
ECHO        
ECHO       9) 준비중입니다...              10) 준비중입니다...            
ECHO        
ECHO     
echo.
echo.
set /p 타이머 및 유틸리티=원하는 선택을 입력후 엔터키를 눌러주세요. 원하는 항목이 없을경우 0을 입력시 초기화면으로 돌아갑니다.
if /i "%타이머 및 유틸리티%"=="1" goto 다운타이머
if /i "%타이머 및 유틸리티%"=="2" goto 컴퓨터 속도 향상
if /i "%타이머 및 유틸리티%"=="3" goto PC 카카오톡 다운
cls

:다운타이머
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794024&nTitleNo=7464300&nRowNum=15&nPageNo=1"
cls
goto first

:PC 카카오톡 다운
start rooms\건들지마세요\카카오톡\카카오톡.exe
cls
goto first

:일간베스트
explorer "https://www.ilbe.com/"
cls
goto first

:오늘의유머
explorer "http://www.todayhumor.co.kr/"
cls
goto first

:인터넷방송갤러리
explorer "http://gall.dcinside.com/board/lists/?id=ib"
cls
goto first

:개드립
explorer "http://dogdrip.net"
cls
goto first

:포모스
explorer "http://www.fomos.kr/talk/article_list?bbs_id=3"
cls
goto first

:와이고수
explorer "http://www.ygosu.com/"
cls
goto first

:인벤
explorer "http://www.inven.co.kr/webzine/"
cls
goto first

:웃긴대학
explorer "http://web.humoruniv.com/main.html"
cls
goto first

:던파조선
explorer "http://df.gamechosun.co.kr/"
cls
goto first

:루리웹
explorer "http://www.ruliweb.com/"
cls
goto first

:모드적용오류해결
explorer "https://www.youtube.com/watch?v=TzknHtfh5Uk"
cls
goto first

:세이브다운
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794024&nTitleNo=10489064&nRowNum=15&nPageNo=1"
cls
start rooms\건들지마세요\카그세이브\카그세이브.bat
cls
goto first

:카오스다운
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=50796777&nTitleNo=17490563&nRowNum=15&nPageNo=1"
cls
goto first

:아이템적용
xcopy "Rooms\건들지마세요\아이템스킨이미지" "gfx\items\collectibles" /y
cls
goto first

:애프터다운
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794028&nTitleNo=20952398&nRowNum=15&nPageNo=1&szSearchWord=&nSearchType=1&nBoardType=0"
cls
goto first

:에픽빔적용
xcopy "Rooms\건들지마세요" "gfx\effects" /y
xcopy "Rooms\건들지마세요\에픽빔소리" "sfx\feedback" /y
cls
goto first

:에픽빔제거
del "gfx\effects\sprite0_strip16.png" /q
del "sfx\feedback" /q
cls
goto first

:라이트제거
del "players.xml" /q
xcopy "Rooms\건들지마세요\노말\players.xml" /s /y
cls
goto first

:라이트적용
del "players.xml" /q
xcopy "Rooms\건들지마세요\라이트\players.xml" /s /y
cls
goto first

:본캐방송국
explorer "http://www.afreeca.com/iwt2hw"
cls
goto first

:부캐방송국
explorer "http://www.afreeca.com/iwt2hw0"
cls
goto first

:노말다운
explorer "https://drive.google.com/file/d/0B8oG5HWMdcOzaUZ2bG9PMmFyRUk/view?usp=sharing"
cls
goto first

:유튜브
explorer "https://www.youtube.com/channel/UCWXBhD5SfoyJ3SUShTLz3WA?sub_confirmation=1"
cls
goto first

:노말세이브
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794024&nTitleNo=8338089&nRowNum=15&nPageNo=1"
cls
start rooms\건들지마세요\노말세이브\노말세이브.bat
goto first


:퀵뷰이벤트
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794022&nTitleNo=19184967&nRowNum=15&nPageNo=1"
cls
goto first

:컴퓨터 속도 향상
start rooms\건들지마세요\임시폴더청소기\임시폴더청소기.exe
cls
goto first

:히오스
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=50796777&nTitleNo=17490563&nRowNum=15&nPageNo=1&szSearchWord=&nSearchType=1&nBoardType=0"
cls
goto first

:브금
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794028&nTitleNo=9558150&nRowNum=15&nPageNo=1"
cls
goto first

:1115
explorer "https://drive.google.com/drive/folders/0B8oG5HWMdcOzdnpIMWxCemRrbDA?usp=sharing"
cls
goto first

:계정변경
explorer "http://cafe.naver.com/isaacb/40339"
cls
goto first

:스팀친추
explorer "http://steamcommunity.com/profiles/76561198123814659"
cls
goto first

:컴복
del /s /q "C:\Users\Administrator\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier"

xcopy /s /y "D:\resources" "C:\Users\Administrator\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier\resources"

xcopy /s /y "D:\content" "C:\Users\Administrator\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier\content"

xcopy "D:\main.lua" "C:\Users\Administrator\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier"
cls
goto first

:노복
del /s /q "C:\Users\MSI PC\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier Test"

xcopy /s /y "D:\resources" "C:\Users\MSI PC\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier Test\resources"

xcopy /s /y "D:\content" "C:\Users\MSI PC\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier Test\content"

xcopy "D:\main.lua" "C:\Users\MSI PC\Documents\My Games\Binding of Isaac Afterbirth+ Mods\Chaos Greedier Test"
cls
goto first

:팀뷰어
start rooms\건들지마세요\팀뷰어\TeamViewer_Setup_ko.exe
start rooms\건들지마세요\팀뷰어\팀뷰어.txt
cls
goto first

:스파이더
explorer "https://drive.google.com/file/d/0B8oG5HWMdcOzOUFfM19KWUp2ejg/view?usp=sharing"
cls
goto first

:리믹스
explorer "https://drive.google.com/file/d/0B8oG5HWMdcOzZEY3Ymszdk84MWs/view?usp=sharing"
start rooms\건들지마세요\리믹스\리믹스.txt
cls
goto first

:톡방
explorer "http://live.afreecatv.com:8079/app/index.cgi?szBoard=read_bbs&szBjId=iwt2hw&nStationNo=8654100&nBbsNo=15794028&nTitleNo=19936284&nRowNum=15&nPageNo=1"
cls
goto first