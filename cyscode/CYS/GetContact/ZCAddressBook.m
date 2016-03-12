//
//  ZCAddressBook.m
//  通讯录Demo
//
//  Created by ZhangCheng on 14-4-19.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "ZCAddressBook.h"
#import "pinyin.h"
#import <AddressBook/AddressBook.h>
#import "POAPinyin.h"

static ZCAddressBook *instance;
@implementation ZCAddressBook
-(id)init
{
    if (self=[super init]) {
        filteredArray=[[NSMutableArray alloc] init];
        sectionDic= [[NSMutableDictionary alloc] init];
        phoneDic=[[NSMutableDictionary alloc] init];
        contactDic=[[NSMutableDictionary alloc] init];
        
    }
    
    return self;
}
// 单列模式
+ (ZCAddressBook*)shareControl{
    @synchronized(self) {
        if(!instance) {
            instance = [[ZCAddressBook alloc] init];
        }
    }
    return instance;
}
#pragma  mark 添加联系人
// 添加联系人（联系人名称、号码、号码备注标签）
- (BOOL)addContactName:(NSString*)name phoneNum:(NSString*)num withLabel:(NSString*)label{
    // 创建一条空的联系人
    ABRecordRef record = ABPersonCreate();    CFErrorRef error;
    // 设置联系人的名字
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
    // 添加联系人电话号码以及该号码对应的标签名
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABPersonPhoneProperty);    ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)num, (__bridge CFTypeRef)label, NULL);    ABRecordSetValue(record, kABPersonPhoneProperty, multi, &error);
    ABAddressBookRef addressBook = nil;
    // 如果为iOS6以上系统，需要等待用户确认是否允许访问通讯录。
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)    {        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)                                                 {                                                     dispatch_semaphore_signal(sema);                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);         dispatch_release(sema);
    }else{
        addressBook = ABAddressBookCreate();     }
    // 将新建联系人记录添加如通讯录中
    BOOL success = ABAddressBookAddRecord(addressBook, record, &error);
    if (!success) {
        return NO;
    }else{
        // 如果添加记录成功，保存更新到通讯录数据库中
        success = ABAddressBookSave(addressBook, &error);        return success ? YES : NO;
    }
}
-(void)loadContacts
{
    [sectionDic removeAllObjects];
    [phoneDic   removeAllObjects];
    [contactDic removeAllObjects];
    for (int i = 0; i < 26; i++) [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
    
    ABAddressBookRef myAddressBook =nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)    {        myAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);        ABAddressBookRequestAccessWithCompletion(myAddressBook, ^(bool granted, CFErrorRef error)                                                 {                                                     dispatch_semaphore_signal(sema);                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);         dispatch_release(sema);
    }else{
        myAddressBook = ABAddressBookCreate();     }
    
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(myAddressBook);
    CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,
                                                        CFArrayGetCount(results),
                                                        results);
    //将结果按照拼音排序，将结果放入mresults数组中
    CFArraySortValues(mresults,
                      CFRangeMake(0, CFArrayGetCount(results)),
                      (CFComparatorFunction) ABPersonComparePeopleByName,
                      (void*) ABPersonGetSortOrdering());
    //遍历所有联系人
    for (int k=0;k<CFArrayGetCount(mresults);k++) {
        ABRecordRef record=CFArrayGetValueAtIndex(mresults,k);
        NSString *personname = (NSString *)ABRecordCopyCompositeName(record);
        ABMultiValueRef phone = ABRecordCopyValue(record, kABPersonPhoneProperty);
        ABRecordID recordID=ABRecordGetRecordID(record);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            NSString * personPhone = (NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            NSRange range=NSMakeRange(0,3);
            NSString *str=[personPhone substringWithRange:range];
            if ([str isEqualToString:@"+86"]) {
                personPhone=[personPhone substringFromIndex:3];
            }
            
            [phoneDic setObject:record forKey:[NSString stringWithFormat:@"%@%d",personPhone,recordID]];
            
            
        }
        char first=pinyinFirstLetter([personname characterAtIndex:0]);
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            if([self searchResult:personname searchText:@"曾"])
                sectionName = @"Z";
            else if([self searchResult:personname searchText:@"解"])
                sectionName = @"X";
            else if([self searchResult:personname searchText:@"仇"])
                sectionName = @"Q";
            else if([self searchResult:personname searchText:@"朴"])
                sectionName = @"P";
            else if([self searchResult:personname searchText:@"查"])
                sectionName = @"Z";
            else if([self searchResult:personname searchText:@"能"])
                sectionName = @"N";
            else if([self searchResult:personname searchText:@"乐"])
                sectionName = @"Y";
            else if([self searchResult:personname searchText:@"单"])
                sectionName = @"S";
            else
                sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([personname characterAtIndex:0])] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        
        [[sectionDic objectForKey:sectionName] addObject:record];
        [contactDic setObject:record forKey:[NSNumber numberWithInt:recordID]];
    }
}

#pragma  mark 指定号码是否已经存在
- (ABHelperCheckExistResultType)existPhone:(NSString*)phoneNum{
    ABAddressBookRef addressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)    {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)                                                 {                                                     dispatch_semaphore_signal(sema);                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);         dispatch_release(sema);
    }else{
        addressBook = ABAddressBookCreate();
    }
    CFArrayRef records;
    if (addressBook) {
        
        // 获取通讯录中全部联系人
        records = ABAddressBookCopyArrayOfAllPeople(addressBook);
    }else{
        
#ifdef DEBUG        NSLog(@"can not connect to address book");
#endif
        return ABHelperCanNotConncetToAddressBook;
    }
    // 遍历全部联系人，检查是否存在指定号码
    for (int i=0; i<CFArrayGetCount(records); i++) {
        ABRecordRef record = CFArrayGetValueAtIndex(records, i);
        CFTypeRef items = ABRecordCopyValue(record, kABPersonPhoneProperty);
        CFArrayRef phoneNums = ABMultiValueCopyArrayOfAllValues(items);
        if (phoneNums) {
            for (int j=0; j<CFArrayGetCount(phoneNums); j++) {                NSString *phone = (NSString*)CFArrayGetValueAtIndex(phoneNums, j);                if ([phone isEqualToString:phoneNum]) {                    return ABHelperExistSpecificContact;                }
            }
        }
    }    CFRelease(addressBook);
    return ABHelperNotExistSpecificContact;
}
#pragma mark 获取通讯录内容
-(NSMutableDictionary*)getPersonInfo{
    self.emailArrayDic=[[NSMutableArray alloc]init];
    self.Dicarr=[[NSMutableArray alloc]init];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArrayDic = [NSMutableArray arrayWithCapacity:0];
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {                accessGranted = granted;
            dispatch_semaphore_signal(sema);        });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    } else {
        addressBook = ABAddressBookCreate();
    }
//    ABAddressBookRef addressBook=nil ;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)    {        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
//        //等待同意后向下执行
//        dispatch_semaphore_t sema = dispatch_semaphore_create(0);        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)                                                 {                                                     dispatch_semaphore_signal(sema);                                                 });
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);         dispatch_release(sema);
//       
//    }else{
//        addressBook = ABAddressBookCreate();     }
    for (int i = 0; i < 26; i++) [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
    

    //取得本地通信录名柄
    
    
    //取得本地所有联系人记录
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFMutableArrayRef mresults=CFArrayCreateMutableCopy(kCFAllocatorDefault,
                                                        CFArrayGetCount(results),
                                                        results);
    //将结果按照拼音排序，将结果放入mresults数组中
    CFArraySortValues(mresults,
                      CFRangeMake(0, CFArrayGetCount(results)),
                      (CFComparatorFunction) ABPersonComparePeopleByName,
                      (void*) ABPersonGetSortOrdering());
    
    //    NSLog(@"-----%d",(int)CFArrayGetCount(results));
    //    NSLog(@"in %s %d",__func__,__LINE__);
    for(int i = 0; i < CFArrayGetCount(mresults); i++)
    {
        NSMutableDictionary *dicInfoLocal = [NSMutableDictionary dictionaryWithCapacity:0];
        ABRecordRef person = CFArrayGetValueAtIndex(mresults, i);
//        //读取firstname
//        NSString *first = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
//        if (first==nil) {
//            first = @" ";
//        }
//        [dicInfoLocal setObject:first forKey:@"first"];
        
//        NSString *last = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
//        if (last == nil) {
//            last = @" ";
//        }
//        [dicInfoLocal setObject:last forKey:@"last"];
        
        NSString *personname = (NSString *)ABRecordCopyCompositeName(person);
//        NSString *first = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if (personname==nil) {
            personname = @" ";
        }
        [dicInfoLocal setObject:personname forKey:@"name"];

        
        
        ABMultiValueRef tmlphone =  ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSString* telphone = (NSString*)ABMultiValueCopyValueAtIndex(tmlphone, 0);
        if (telphone == nil) {
            telphone = @" ";
        }
        [dicInfoLocal setObject:telphone forKey:@"telphone"];
        CFRelease(tmlphone);
       
         //获取的联系人单一属性:Email(s)
         
         ABMultiValueRef tmpEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
         
         NSString *email = (NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, 0);
         //[dicInfoLocal setObject:email forKey:@"email"];
         
         CFRelease(tmpEmails);
         if (email==nil) {
         email = @" ";
             [dicInfoLocal setObject:email forKey:@"email"];
         }else{
             [dicInfoLocal setObject:email forKey:@"email"];
            // NSLog(@"%@",dicInfoLocal);
             [self.emailArrayDic addObject:dicInfoLocal];
         }
        
            [self.dataArrayDic addObject:dicInfoLocal];
        
    }
    CFRelease(results);//new
    CFRelease(mresults);
    CFRelease(addressBook);//new
    
    //排序
    //建立一个字典，字典保存key是A-Z  值是数组
    NSMutableDictionary*index=[NSMutableDictionary dictionaryWithCapacity:0];
    
    for (NSDictionary*dic in self.dataArrayDic) {
        
        NSString* str=[dic objectForKey:@"name"];

        NSString *strFirLetter = [NSString stringWithFormat:@"%c",pinyinFirstLetter([str characterAtIndex:0])];
        
       
        char first=pinyinFirstLetter([str characterAtIndex:0]);
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            if([self searchResult:str searchText:@"曾"])
                sectionName = @"Z";
            else if([self searchResult:str searchText:@"解"])
                sectionName = @"X";
            else if([self searchResult:str searchText:@"仇"])
                sectionName = @"Q";
            else if([self searchResult:str searchText:@"朴"])
                sectionName = @"P";
            else if([self searchResult:str searchText:@"查"])
                sectionName = @"Z";
            else if([self searchResult:str searchText:@"能"])
                sectionName = @"N";
            else if([self searchResult:str searchText:@"乐"])
                sectionName = @"Y";
            else if([self searchResult:str searchText:@"单"])
                sectionName = @"S";
            else
                sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([str characterAtIndex:0])] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        // NSLog(@"%@",sectionName);
       [[sectionDic objectForKey:sectionName] addObject:dic];
 
    }
  
    [self.dataArray addObjectsFromArray:[index allKeys]];
    
    [self.Dicarr addObject:index];
    
    NSMutableDictionary *mydic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:sectionDic,@"dic",self.emailArrayDic,@"emaildic", nil];
      NSLog(@"%@",mydic);
    return mydic;
}
-(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT{
    NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch
                                               range:NSMakeRange(0, searchT.length)];
    if (result == NSOrderedSame)
        return YES;
    else
        return NO;
}


#pragma  mark 字母转换大小写--6.0
-(NSString*)upperStr:(NSString*)str{
    
    //    //全部转换为大写
//        NSString *upperStr = [str uppercaseStringWithLocale:[NSLocale currentLocale]];
//        NSLog(@"upperStr: %@", upperStr);
    //首字母转换大写
//        NSString *capStr = [str capitalizedStringWithLocale:[NSLocale currentLocale]];
//        NSLog(@"capStr: %@", capStr);
    //    // 全部转换为小写
    NSString *lowerStr = [str lowercaseStringWithLocale:[NSLocale currentLocale]];
        NSLog(@"lowerStr: %@", lowerStr);
    return lowerStr;
    
}
#pragma mark 排序
-(NSArray*)sortMethod
{
    
    
    NSArray*array=  [self.dataArray sortedArrayUsingFunction:cmp context:NULL];
    return array;
    
}
//构建数组排序方法SEL
//NSInteger cmp(id, id, void *);
NSInteger cmp(NSString * a, NSString* b, void * p)
{
    if([a compare:b] == 1){
        return NSOrderedDescending;//(1)
    }else
        return  NSOrderedAscending;//(-1)
}

#pragma mark 使用系统方式进行发送短信，但是短信内容无法规定
+(void)sendMessage:(NSString*)phoneNum{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:  [NSString stringWithFormat:@"sms:%@",phoneNum]]];
    
}

-(id)initWithTarget:(id)target MessageNameArray:(NSArray*)array Message:(NSString*)str Block:(void (^)(int))a
{
    if (self=[super init]) {
        self.target=target;
        self.MessageBlock=a;
        [self showViewMessageNameArray:array Message:str];
    }
    return self;
}
-(void)showViewMessageNameArray:(NSArray*)array Message:(NSString*)str{
    
    //判断当前设备是否可以发送信息
    if ([MFMessageComposeViewController canSendText]) {
        
        MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
        
        //委托到本类
        messageViewController.messageComposeDelegate = self;
        
        //设置收件人, 需要一个数组, 可以群发短信
        messageViewController.recipients = array;
        
        //短信的内容
        messageViewController.body =str;
        
        //打开短信视图控制器
        [self.target presentViewController:messageViewController animated:YES completion:nil];
        
        [messageViewController release];
    }
    
    
}
#pragma mark MFMessageComposeViewController 代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    //0 取消  1是成功 2是失败
    NSLog(@"~~~%d",result);
    self.MessageBlock(result);
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(id)initWithTarget:(id)target PhoneView:(void (^)(BOOL, NSDictionary *))a
{
    if (self=[super init]) {
        self.target=target;
        self.PhoneBlock=a;
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [self.target presentViewController:peoplePicker animated:YES completion:nil];
        [peoplePicker release];
        
    }
    
    return self;
}
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //获得选中Vcard相应信息
    /*
     ABMutableMultiValueRef address=ABRecordCopyValue(person, kABPersonAddressProperty);
     ABMutableMultiValueRef birthday=ABRecordCopyValue(person, kABPersonBirthdayProperty);
     ABMutableMultiValueRef creationDate=ABRecordCopyValue(person, kABPersonCreationDateProperty);
     ABMutableMultiValueRef date=ABRecordCopyValue(person, kABPersonDateProperty);
     ABMutableMultiValueRef department=ABRecordCopyValue(person, kABPersonDepartmentProperty);
     ABMutableMultiValueRef email=ABRecordCopyValue(person, kABPersonEmailProperty);
     ABMutableMultiValueRef firstNamePhonetic=ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
     
     ABMutableMultiValueRef instantMessage=ABRecordCopyValue(person, kABPersonInstantMessageProperty);
     ABMutableMultiValueRef jobTitle=ABRecordCopyValue(person, kABPersonJobTitleProperty);
     ABMutableMultiValueRef kind=ABRecordCopyValue(person, kABPersonKindProperty);
     ABMutableMultiValueRef lastNamePhonetic=ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
     ABMutableMultiValueRef middleNamePhonetic=ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
     ABMutableMultiValueRef middleName=ABRecordCopyValue(person, kABPersonMiddleNameProperty);
     ABMutableMultiValueRef modificationDate=ABRecordCopyValue(person, kABPersonModificationDateProperty);
     ABMutableMultiValueRef nickname=ABRecordCopyValue(person, kABPersonNicknameProperty);
     ABMutableMultiValueRef note=ABRecordCopyValue(person, kABPersonNoteProperty);
     ABMutableMultiValueRef organization=ABRecordCopyValue(person, kABPersonOrganizationProperty);
     ABMutableMultiValueRef phone=ABRecordCopyValue(person, kABPersonPhoneProperty);
     ABMutableMultiValueRef prefix=ABRecordCopyValue(person, kABPersonPrefixProperty);
     ABMutableMultiValueRef relatedNames=ABRecordCopyValue(person, kABPersonRelatedNamesProperty);
     ABMutableMultiValueRef socialProfile=ABRecordCopyValue(person, kABPersonSocialProfileProperty);
     ABMutableMultiValueRef personSuffix=ABRecordCopyValue(person, kABPersonSuffixProperty);
     ABMutableMultiValueRef _URL=ABRecordCopyValue(person, kABPersonURLProperty);
     */
    
    NSString* firstName=(NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (firstName==nil) {
        firstName = @" ";
    }
    NSString* lastName=(NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (lastName==nil) {
        lastName = @" ";
    }
    NSMutableArray *phones = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        
        NSString *aPhone = [(NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i) autorelease];
        
        [phones addObject:aPhone];
        
    }
    NSDictionary*dic=@{@"firstName": firstName,@"lastName":lastName,@"phones":phones};
    
    self.PhoneBlock(YES,dic);
    
    [self.target dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
    self.PhoneBlock(NO,nil);
    [self.target dismissViewControllerAnimated:YES completion:nil];
    
    
    
    return NO;
    
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    self.PhoneBlock(NO,nil);
    [self.target dismissViewControllerAnimated:YES completion:nil];
    
}

@end
