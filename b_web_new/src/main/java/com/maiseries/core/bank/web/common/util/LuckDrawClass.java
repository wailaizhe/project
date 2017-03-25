package com.maiseries.core.bank.web.common.util;

import java.util.Random;


// 抽奖逻辑代码
public class LuckDrawClass {
	
	static int four=85;
	static int three=95;
	static int two=98;
	static int one=101;
	
	 
	
	/**
	 * 抽奖逻辑 
	 * @param onePrize 特等中奖个数
	 * @param onePrize 一等中奖个数
	 * @param twoPrize 二等中奖个数
	 * @param threePrize 三等中奖个数
	 * @param fourPrize  四等中奖个数
	 * @param type  可以抽奖类型
	 * @return
	 */
	public final static String luckDraw(int grandPrize,int onePrize,int twoPrize,int threePrize,int fourPrize,String type){
		
		int number=64; // 设置的随机数字范围
		
		if("01".equals(type)){        //该用户可以抽取一等奖
			number = one;
		}else if("02".equals(type)){  //该用户可以抽取二等奖
			number = two;
		}else if("03".equals(type)){  //该用户可以抽取三等奖
			number = three;
		}else if("04".equals(type)){  //该用户可以抽取四等奖
			number = four;
		}
		
		int goldNumber=0;  //随机金币数
		int isPrize=5;     //用户抽取的奖项等级
		int i = (int)(Math.random()*number);  //随机抽取的数字
	     
		if(i>=65){
			
			if(i==100&&1-grandPrize>0){  //特等奖 一天仅有一位中奖用户
				goldNumber = randomGoldNumber(1000, 800);
	        	isPrize=0;
			}
			
	        if(i<=99&&i>=98&&2-onePrize>0){  // 一等奖  二名中奖用户
	        	goldNumber = randomGoldNumber(100, 81);
	        	isPrize=1;
	        }
	        
	        if(i<=97&&i>=95&&3-twoPrize>0){  // 二等奖  三名中奖用户
	        	goldNumber = randomGoldNumber(80, 51);
	        	isPrize=2;
	        }
	         
	        if(i<=94&&i>=85&&10-threePrize>0){   // 三等奖  十名中奖用户
	        	goldNumber = randomGoldNumber(50, 31);
	        	isPrize=3;
	        }
	        
	        if(i<=84&&i>=65&&20-fourPrize>0){  // 四等奖  二十名中奖用户
	        	goldNumber = randomGoldNumber(30, 1);
	        	isPrize=4;
	        }
		}
		
        //System.err.println(isPrize+"--------------"+i+"==========="+goldNumber);
		
		return isPrize+"_"+goldNumber+"_"+i;  //抽中奖项，抽中金币，中奖数字
	}
	
	
	
	/**
	 * 随机金币数例如 max=20 min=10,则随机10~20 之间的数字  
	 */
	public static int  randomGoldNumber(int max,int min){
	    Random random = new Random();
	    int s = random.nextInt(max)%(max-min+1) + min;
	    return s;
	}
	
	
//	public static void main(String[] args) {
//		for(int i=0;i<100;i++ ){
////			System.err.println(luckDraw(0,0,0,0,0,"05"));
//			System.err.println(randomGoldNumber(1000,800));
//		}
//	}
	
}
