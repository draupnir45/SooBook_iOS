//
//  SBMainTableViewController.m
//  SbProject0330
//
//  Created by 홍정기 on 2017. 3. 30..
//  Copyright © 2017년 ios school. All rights reserved.
//

#import "SBMainTableViewController.h"

//섹션 헤더
#import "FirstSectionHeaderCell.h"
#import "SecondSectionHeaderCell.h"

//첫번째 섹션 셀
#import "FirstSectionTableViewCell.h"
#import "CollectionViewDataSource.h"
#import "BookCoverCollectionViewCell.h"

//두번째 섹션 셀
#import "SecondSectionTableViewCell.h"

//디테일 뷰
#import "DetailViewController.h"

@interface SBMainTableViewController ()
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property CollectionViewDataSource *firstSectionCollectionViewDataSource;
@property NSArray *mainImageArray;
@property NSArray *titleLabelArray;
@property NSArray *subLabelArray;
@property NSArray *contentsArray;
@end

@implementation SBMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"내 책장";
    
    
    
     //NSArray *collectionDataArr = @[@"1", @"2",@"3",@"4",@"5",@"6"];
    
/////////////////////////////////테스트용 DataSource//////////////////////////////////
    
    self.titleLabelArray  = @[@"엘리자베스가 사라졌다",@"걸 온 더 트레인",@"영어책 한권 외워봤니?",@"드라마 도깨비 소설2 - 쓸쓸하고 찬란하神",@"여교수와 남제자",@"겨울에서 봄",@"드래곤볼 슈퍼",@"사랑해, 심청아!",@"타락천사",@"말괄량이의 늑대 길들이기: 늑대삼형제 시리즈"];
    self.mainImageArray = @[@"1.jpeg",@"2.jpeg",@"3.jpeg",@"4.jpeg",@"5.jpeg",@"6.jpeg",@"7.jpeg",@"8.jpeg",@"9.jpeg",@"10.jpeg"];
    self.subLabelArray  = @[@"엠마 힐리 2016년 10월 24일",@"폴라 호킨스 Paula Hawkins 2015년 8월 10일",@"김민식 2017년 1월 17일",@"김수연 2017년 2월 17일",@"강민 2016년 10월 6일",@"그린라이프 2017년 3월 7일",@"TORIYAMA Akira 2016년 7월 1일",@"김원경 2017년 2월 3일",@"김원경 2017년 1월 17일",@"김원경 2016년 11월 25일"];
    self.contentsArray =  @[@"■ 저자: 엠마 힐리 Emma Healey 엠마 힐리는 네 살 때 처음으로 짧은 이야기를 썼고, 여덟 살 때 선생님에게 작가가 될 거라고 말했지만, 열두 살 즈음에는 철이 들어 소송 전문 변호사가 되기로 마음먹었다(순전히 영화 <클루리스(Clueless)> 때문이었다). 그로부터 10년이 더 흘러서야 그녀는 다시 글을 쓰기 시작했다. 런던에서 자라면서 예술 대학에 다니고 제본으로 학사학위를 땄다. 그 후 두 도서관, 두 서점, 두 미술관, 두 대학에서 일하며 예술계에서 바쁘게 경력을 쌓은 뒤 전업 작가로서의 인생을 시작했다. 2010년에는 노리치로 옮겨 가 문학 석사가 되기 위해 이스트앵글리아 대학에서 공부했고 다시는 돌아가지 않았다. 『엘리자베스가 사라졌다』는 엠마 힐리의 첫 장편소설이다. 이 작품은 2014년 코스타 북 어워드 데뷔작 상을 받고 2015년 데스먼드 엘리엇 상 후보에 올랐다. ",@"■ 저자: 폴라 호킨스 Paula Hawkins 짐바브웨에서 태어나 자랐다. 그녀의 집은 경제학 교수이자 금융 저널리스트인 아버지를 만나기 위해 찾아오는 해외 특파원들로 시끌벅적했다. 그녀는 열일곱 살에 가족과 함께 런던으로 이주했다. 몇 년 후 부모님은 짐바브웨로 돌아갔지만 그녀는 영국에 남아 옥스퍼드대학에서 경제학, 정치학, 철학을 공부했다. 이후 <타임스>의 경제부 기자가 되어 15년간 기자 생활을 했다. ",@"영어가 잘 되면 인생이 술술 풀린다!영어 고수, 30년 독학의 신이 알려주는 영어 공부 필살기 자동번역기와 각종 어플리케이션의 등장으로 그 어느 때보다 쉽게 영어를 학습할 수 있는 때이다. 그럼에도 불구하고 사람들은 여전히 스트레스를 받으며, 영어 공부에 돈을 쏟아 붓고 있다. 보통의 성인들이 학창시절부터 영어 공부를 한 햇수는 20년은 족히 넘을 것이다. 또 부모가 되어서는 자식에게도 큰돈을 들이면서 영어에 집착한다. 이러한 현실에서 중학교 영어 교과서 외우기로 영어 세계에 입문하여 아무도 토익, 토플을 공부하지 않던 시절에 취미로 공부한 영어 덕분에 외국계 기업에 취직하고, 미국의 [프렌즈] 같은 시트콤을 만들고 싶어 드라마 피디가 된 사람이 있다. 그는 유학은커녕 어학연수, 회화 학원 한 번 다니지 않고 30년 독학으로 습득한 영어 공부 노하우를 『영어책 한 권 외워봤니?』에 담아냈다.",@" 2016~2017 화제의 드라마[도깨비] 소설 출간!운명과 저주 그 어디쯤에서 만난 도깨비와 어린 인간 신부 소설로만 만날 수 있는 애틋하고 섬세한 이야기 가슴 설레는 스토리, 예상치 못한 전개, 감동적이고 따뜻한 메시지, 마음에 스며드는 대사들로 매 방송마다 큰 화제를 불러일으킨 tvN 드라마 [도깨비]가 소설로 출간되었다. [도깨비]는 도깨비의 탄생부터 그 탄생의 배경, 이와 관련된 전생과 현생, 도깨비 신부, 저승사자 등 여러 인물들을 감싼 촘촘하고 매력적인 서사로 뜨거운 사랑을 받았다. 또한 인연과 운명, 삶과 죽음, 의지와 선택이라는 여러 겹의 이야기들이 차곡차곡 쌓여 삶에 대한 다양한 이야기들을 전했다. 소설 『도깨비』는 김은숙 원작 드라마 [도깨비]를 소설로 각색, 전 2권으로 구성되었다. 소설에는 드라마 이면에 자리한 등장인물들의 숨은 이야기가 담겨 있으며, 김은숙 작가 특유의 감각적인 대사와 생생한 캐릭터 묘사에 섬세한 감정의 결이 더해졌다. 이런 입체적인 스토리는 읽는 즐거움과 드라마와는 또 다른 감동과 설렘을 선사할 것이다.",@"“저..교수님..가슴 마사지를 해야 하는데...손을 넣어도 될런지요?” “음~ 그래...얼마든지..그냥 브라를 벗고 하지 뭐~ 일어서기 귀찮은데 손 넣어서 브라 좀 풀어줘..” 제자의 손에 앙증맞은 그녀의 브라가 벗겨지자 오일로 범벅이 되어있던 미향의 풍만한 젖가슴이 출렁출렁 춤을 추었다. 그는 조심스레 미향의 젖가슴에 두 손을 올리며 부드럽게 애무를 시작했다. 검지와 중지 사이에 그녀의 딱딱한 유두를 끼워놓고 쌔기 쥐었다 폈다를 하며 두 손으로 감싸도 모자를 만큼 큰 그녀의 두 유방을 미친 듯이 비벼대고 있었다. “음~ 아~~~ 아..너무 좋다 얘~ “ 그의 손이 옆구리를 타고 내릴 때, 미향의 아래에선 끈적한 물이 넘쳐 흘렀다. 미향은 찌릿한 느낌에 눈을 꼭 감았다. 그는 두 손가락으로 그녀의 팬티 속에 손을 넣어 양쪽의 볼록한 살들을 비비며 그녀를 자극하고 있었다. ‘아...그냥 확 넣어버릴까..?’ -본문 중-",@"[독점/강추!]아팠던 겨울을 넘어 봄을 기다립니다. ‘무슨 이야기가 얽혀 있을까?’ 쏠리는 마음을 가까스로 붙들어 매던 차에 불쑥 눈길을 끄는 것이 있었다. 손전화 위를 바삐 오가는 손……. 그 하얀 손등 위에 까만 점 하나가 도드라졌다.저자 정보 그린라이프 꽃이나 나무와 늘 함께하고 싶습니다. 전자책 출간: 「첫사랑은 배꽃처럼」「아지랑이」「꿈꾸는 빗방울」 「그 뒤, 그들은 어떻게 살았을까?」「별꽃과 달팽이」「번데기와 날벌레」「둥근 달이 떴습니다」 「그린라이프 풀빛 첫사랑 시리즈」「겨울에서 봄」 종이책 출간: 「극과 극의 남녀」",@"손오공과 마인부우의 장대한 싸움으로부터 세월이 흘러…평화를 되찾은 세상에 다시금 새로운 위기가!! 이번 적은 에서 왔다!? 토리야마 아키라 오리지널 원안으로 를 그린, 완전 신작 개막!",@"에피루스 베스트 로맨스 소설! 쓰러진 부친 대신 자신을 희생해 집안을 돌봐 온 현대판 효녀 심청, 청아. 돈을 벌기 위해 학교도 포기해야 했던 그녀에게 기적 같은 기회가 다가왔고 그렇게 스무 살 나이로 뒤늦게 편입한 고등학교 음악실에서 감미로운 피아노 선율과 함께 다가온 그 남자, 한해신을 만났다. “선생님, 저한테 왜 이러세요?” “항상 이러고 싶었으니까. 좋아하니까. 아니, 사랑해. 사랑한다, 심청아.” 꽃향기 가득한 봄, 누릴 기회조차 없이 지나쳐 버린 사춘기처럼 뒤늦게 그녀에게로 찾아온 풋풋한 첫사랑. 그 결말은? [연작 가이드] 「송은교, 육체를 바꾸다」: 은교는 좋아하는 가수 세영의 코디네이터로 일하며 친해지게 되지만 어느 날 저승사자의 실수로 죽고 마는데! 대신 교통사고로 죽은 우현의 아내 소리의 몸에 들어가면서 벌어지는 이야기. 「사랑해, 심청아」: 이름 때문에 착한여자 콤플렉스에 시달리는 심 청아. 집안이 어려워 서울에서 우현의 집안일을 도우며 살고 있다. 주인댁의 도움으로 명문 고등학교에 다니게 된 청아는 교생선생님 해신에게 반하게 된다. 「찰떡궁합」: 청아를 짝사랑했던 주인은 7년 후 명문 고등학교의 이사장으로 오게 된다. 그리고 그를 짝사랑했던 청아의 친구 은영도 미술 선생님으로 부임한다. [본문 중에서] “선생님!” “응?” “담배 끊어요.” “담배? 나의 유일한 낙을 끊으면 뭐 해줄 건데?” “선생님 좋으라고 끊으란 건데…… 뭘 원하는데요? 저 가난한 거 아시죠?” “돈 드는 거 말고. 힘으로 하는 걸로.” 몸으로 때우는 건 어때? 하고 말하기엔 어린 그녀가 너무 놀랄까 봐 말을 삼킨 것이다. “또 제가 은근히 힘쓰는 건 어찌 아셨어요? 티 나나?” 청아는 자신의 팔뚝을 살펴보다가 얼굴을 붉히면서 그를 문밖으로 밀어냈다. 방문을 닫은 청아는 문에 기대어 입을 막은 채 웃었다. 그날 밤 청아는 마치 어린아이처럼 들떠 있었다. 해신의 좋아한다는 고백에, 또 주민과 사귀는 사이가 아니란 말에 날아갈 것 같은 기분이 들었다. 하긴 천천히 가잔 말은 좀 서운하기는 했지만 서두르는 것보단 나을지도 몰랐다. 창문을 활짝 연 청아는 깊이 숨을 들이쉬었다. 그가 창문을 조금 연채로 피아노를 치기 시작했는지, 캐논 변주곡이 왠지 좀 더 경쾌하고도 즐거운 선율로 흘렀다.",@"에피루스 베스트 로맨스 소설! “네가 바로 그 까마귀라. 사내인 줄 알았더니 아가씨였구나.” 작고 검은 날개를 지녀 까마귀라 불리는 천사족 아가씨, 연오. 천신의 딸이란 신분을 숨기고 들어간 천예궁에서 마침내 동경하던 흑천사, 흑륜을 만난다. 그리고 충동적으로 입맞춤을 나눈 그날 밤, 그와 사랑을 나누는 꿈을 꾸고 만다. 그때야 알았다. 언제부터인가 자신이 그를 좋아하게 되었다는 사실을. “이상하게도 이곳으로 오면, 당신을 만날 수 있을 것 같았습니다.” 마계의 왕과 초대 흑천사의 피를 이어 전쟁을 위해 태어난 타락천사, 흑륜. 어머니를 구하려면 또 다른 흑천사 연오에게서 아이를 얻고 그녀를 죽여야 한다. 그래서 접근했는데. 사랑이 아니라 자신했는데, 자각한 순간 이미 늦었다는 것을 깨달았다. 마음이 이어진 순간 하나로 엮인, 상반된 두 인연의 붉은 실. 운명마저 거스른 타락천사, 그들의 사랑이 시작된다! [본문 중에서] “이상하게도 이곳으로 오면 만날 수 있을 것 같았습니다.” “나를 찾기엔 너무 이른 시간이 아닐까? 내게서 무엇을 원하는 게냐?” 이 시간, 이런 곳에서 그녀를 만났으면서도 흑륜은 별로 놀라는 눈치가 아니었다. 연오는 그도 자신을 기다리고 있었던 것 같은 기분이 들었다. 아니라면 그 또한 이 시간에 이곳에 있을 리가 없지 않은가. “요즘 계속 흑륜 님이 나오는 꿈을 꿉니다.” “그래서?” “이런 꿈을 계속 꾸는 이유가 궁금합니다.” “네 꿈에 관한 이야기를 왜 나에게 묻는 것이냐.” “그렇군요. 하지만 그날…… 입맞춤을 한 이후부터 그런 꿈을 꾸는 것 같아 혼란스럽습니다.” “내가 어떻게 해주길 원하느냐? 이미 해버린 입맞춤을 무를 수도 없는 일이고 혹, 그 이상의 것을 원하는 것이더냐?” 놀리는 듯하면서도 나른한 말투에 당황한 연오는 고개를 내저었다. “아닙니다. 무슨…… 그런 일은 원하지 않습니다.” “도대체 어떤 꿈을 꾸는데, 까마귀가 이 시간에 나를 찾았을까.” 흑륜은 곤란해하는 연오가 재밌어서, 일부러 더 몰아붙였다. 연오는 지금 흑륜이 자신을 놀리고 있다는 것을 깨닫고 좀 더 강력하게 대응해 보기로 하였다. 처음 만난 날처럼 속수무책으로 당하지는 않을 작정이었다. 어차피 남자로까지 오해를 받고 또 입맞춤까지 한 사이가 아니던가! 꿈속에선 더한 것도 나눈 사이인데 더 이상 가릴 것이 없었다. “그것이 말입니다. 망측하기 그지없는 꿈입니다만 들어 보시겠습니까?” 흑륜이 고개를 끄떡이자 연오는 조금 머뭇거리는가 싶더니 이내 꿈 이야기를 털어놓기 시작하였다.",@"〈강추!〉세상에 그 많은 우연 중에 하필 이런 우연이……. “할아버지! 저는 절대로 정혼자하고는 결혼 안 할 거예요! 결혼을 해도 제가 찾을 거라고요!” “네가 지금 내 말을 거역하것다 이거여? 잔말 말고 물러가도록 혀!” 뼈대 있는 집안의 장녀 김유나가 정혼자를 만나러 서울에 상경하다. 그런데 당분간 지낼 그 집에서 웬 가정부 노릇? 알고 보니 그녀가 간 곳은 방배동 청담빌라 101호가 아닌 청담동 청담빌라 101호. “그럼, 내가 집을 잘못 찾아가서 살고 있었단 말이여? 그동안 내가 뼈 빠지게 가정부 노릇한 건 어쩌고? 그리고 난 이미 다른 사람을 사랑해 버린걸…….” 요리 잘하고 태권도 3단에 성격까지 좋은 그녀! 단지 취약점이 있다면 공부를 못했다는 것. 정혼자가 아닌 다른 남자를 사랑하게 된 말괄량이 유나의 유쾌한 반란. 과연 그녀는 뒤바뀐 운명을 바로잡을 수 있을까. 김원경의 로맨스 장편 소설 『말괄량이의 늑대 길들이기』."];

    self.firstSectionCollectionViewDataSource = [[CollectionViewDataSource alloc] initWithSbDataArray:self.titleLabelArray];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstSectionHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FirstSectionHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondSectionHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SecondSectionHeaderCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondSectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SecondSectionTableViewCell"];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
   
    UIImage *naviBarLogo = [UIImage imageNamed: @"logoForNavigation"];
    UIImageView *titleImageview = [[UIImageView alloc] initWithImage: naviBarLogo];
    self.navigationItem.titleView = titleImageview;
    
}
- (void)viewDidAppear:(BOOL)animated {
    if ([[[SBAuthCenter sharedInstance] userToken] length] == 0) {
        [self performSegueWithIdentifier:@"LogInSegue" sender:self];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0 :
            return 1;
            break;
            
        default:
            return self.titleLabelArray.count; //나중에 교체 필요
            break;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            {
                FirstSectionHeaderCell *view = [tableView dequeueReusableCellWithIdentifier:@"FirstSectionHeaderCell"];
                view.titleLabel.text = @"내가 높게 평가한 책들";
                return view;
                break;
            }
        default:
            {
                SecondSectionHeaderCell *view = [tableView dequeueReusableCellWithIdentifier:@"SecondSectionHeaderCell"];
                view.secondLabel.text = @"나의 책 목록";
                return view;
                break;
            }
        }
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        FirstSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstSectionTableViewCell" forIndexPath:indexPath];
        [cell.collectionView registerNib:[UINib nibWithNibName:@"BookCoverCollectionViewCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"BookCoverCollectionViewCell"];
        cell.collectionView.delegate = self;
        cell.collectionView.dataSource = self.firstSectionCollectionViewDataSource;
        return cell;
        
    } else {
        SBBookData *item = [[[SBDataCenter sharedBookData] myBookDatas] objectAtIndex:indexPath.row];
        SecondSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondSectionTableViewCell" forIndexPath:indexPath];
        [cell setCellDataWithImageName:item.imageURL
                                 title:item.title
                              subtitle:item.author];
        cell.tag = indexPath.row;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        switch (section) {
            case 0:
                return 40.0;
                break;
                
            default:
            {
                return 64.0;
                break;
            }
        }
    }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 172.0;
            break;
            
        default:
            return 192.0;
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:[collectionView cellForItemAtIndexPath:indexPath]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - CollectionView Delegate (첫 섹션 컬렉션뷰 커스텀을 위한 코드)

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0,16.0,0.0,16.0); // top, left, bottom, right
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sizeForItemAtIndexPath");
    CGFloat heightByWidthRatio = [BookCoverCollectionViewCell getImageRatioWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",indexPath.item+1]]];
    if (heightByWidthRatio <= (172.0/96.0)) {
        return CGSizeMake(96.0, 172.0);
    } else {
        CGFloat newWidth = 172.0 / heightByWidthRatio;
        return CGSizeMake(newWidth, 172.0);
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        DetailViewController *detailViewController = segue.destinationViewController;
        NSInteger row;
        if ([sender isMemberOfClass:[UITableViewCell class]]) {
            UITableViewCell *senderCell = sender;
            row = senderCell.tag;
        } else {
            UICollectionViewCell *senderCell = sender;
            row = senderCell.tag;
        }
        
        detailViewController.secondString = self.subLabelArray[row];
        detailViewController.imageString = self.mainImageArray[row];
        detailViewController.contentsString = self.contentsArray[row];
        detailViewController.mainNameString = self.titleLabelArray[row];
    }
}

@end
