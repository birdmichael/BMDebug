//
//  BMAppConfigTableViewController.m
//  Pods
//
//  Created by BirdMichael on 2018/12/24.
//

#import "BMAppConfigTableViewController.h"
#import "BMDebugManager.h"
#import "FLEXUtility.h"
#import "FLEXRuntimeUtility.h"
#import "FLEXPropertyEditorViewController.h"
#import <objc/runtime.h>

@interface BMPropertyBox : NSObject
@property (nonatomic, assign) objc_property_t property;
@end
@implementation BMPropertyBox
@end

@interface BMAppConfigTableViewController ()

@property (nonatomic, strong) NSArray<BMPropertyBox *> *systemInfo;
@property (nonatomic, strong) NSArray<BMPropertyBox *> *properties;

@end

@implementation BMAppConfigTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"App Config";
    
    
    [self updateFilteredProperties];
}
- (void)updateFilteredProperties
{
    Class class = [[BMDebugManager sharedInstance].appConfig class];
    NSArray<BMPropertyBox *> *unsortedFilteredProperties = [[self class] propertiesForClass:class];
    
    self.systemInfo = [unsortedFilteredProperties sortedArrayUsingComparator:^NSComparisonResult(BMPropertyBox *propertyBox1, BMPropertyBox *propertyBox2) {
        NSString *name1 = [NSString stringWithUTF8String:property_getName(propertyBox1.property)];
        NSString *name2 = [NSString stringWithUTF8String:property_getName(propertyBox2.property)];
        return [name1 caseInsensitiveCompare:name2];
    }];
    [self.tableView reloadData];
}

- (void)initAppConfigInfo
{
    
    self.systemInfo = [NSMutableArray array];
    
}

+ (NSArray<BMPropertyBox *> *)propertiesForClass:(Class)class
{
    if (!class) {
        return @[];
    }
    
    NSMutableArray<BMPropertyBox *> *boxedProperties = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &propertyCount);
    if (propertyList) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            BMPropertyBox *propertyBox = [[BMPropertyBox alloc] init];
            propertyBox.property = propertyList[i];
            [boxedProperties addObject:propertyBox];
        }
        free(propertyList);
    }
    return boxedProperties;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.systemInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SystemInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = [NSString stringWithCString:property_getName(self.systemInfo[indexPath.row].property) encoding:NSUTF8StringEncoding];
    id propertyValue = [[BMDebugManager sharedInstance].appConfig valueForKey:cell.textLabel.text];
    if ([propertyValue isKindOfClass:[NSString class]]) {
        cell.detailTextLabel.text = propertyValue;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[FLEXPropertyEditorViewController alloc] initWithTarget:[BMDebugManager sharedInstance].appConfig property:self.systemInfo[indexPath.row].property];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
