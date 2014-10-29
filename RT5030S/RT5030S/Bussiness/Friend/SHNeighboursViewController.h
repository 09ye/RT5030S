//
//  SHNeighboursViewController.h
//  RT5030S
//附件人
//  Created by yebaohua on 14-9-21.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHNeighboursViewController : SHTableViewController<SHTaskDelegate,UISearchBarDelegate>
{
    __weak IBOutlet UISearchBar *mSearch;
    NSDictionary * mResult;
    
}

@end
