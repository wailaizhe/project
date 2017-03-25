package com.maiseries.core.bank.web.common;

import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.*;
import com.jfinal.core.JFinal;
import com.jfinal.json.MixedJsonFactory;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.cron4j.Cron4jPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;
import com.jfinal.template.Engine;
import com.maiseries.core.bank.web.account.AccountRoute;
import com.maiseries.core.bank.web.baseInfo.BaseInfoRoute;
import com.maiseries.core.bank.web.common.model._MappingKit;
import com.maiseries.core.bank.web.invest.InvestRoute;
import com.maiseries.core.bank.web.item.ItemRoute;
import com.maiseries.core.bank.web.loan.LoanRoute;
import com.maiseries.core.bank.web.order.OrderRoute;

/**
 * 加载系统配置
 * Created by Delicate on 2017/2/24.
 */
public class BaseConfig extends JFinalConfig {

    private static Prop p = loadConfig();
    private WallFilter wallFilter;

    /**
     * 启动入口，运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
     *
     * 使用本方法启动过第一次以后，会在开发工具的 debug、run configuration 中自动生成
     * 一条启动配置项，可对该自动生成的配置再继续添加更多的配置项，例如 VM argument 可配置为：
     * -XX:PermSize=64M -XX:MaxPermSize=256M
     * 上述 VM 配置可以缓解热加载功能出现的异常
     */
    public static void main(String[] args) {
        /**
         * 特别注意：Eclipse 之下建议的启动方式
         */
    	JFinal.start("src/main/webapp", 80, "/", 5);
        //System.out.println("aaa");
        /**
         * 特别注意：IDEA 之下建议的启动方式，仅比 eclipse 之下少了最后一个参数
         */
    	//JFinal.start("src/main/webapp", 80, "/");
    }

    private static Prop loadConfig() {
        try {
            // 优先加载生产环境配置文件
            return PropKit.use("bank_web_config_pro.txt");
        } catch (Exception e) {
            // 找不到生产环境配置文件，再去找开发环境配置文件
            return PropKit.use("bank_web_config_dev.txt");
        }
    }


    public void configConstant(Constants me) {
        me.setDevMode(p.getBoolean("devMode",true));//开启开发模式
        me.setViewType(ViewType.JSP);//选择模板语言
        me.setJsonFactory(MixedJsonFactory.me());//选择json工厂
    }
    /* 分业务包各自新建route 此处加载各routes */
    public void configRoute(Routes me) {
    	
        me.add(new BaseInfoRoute());
        me.add(new InvestRoute());
        me.add(new LoanRoute());
        me.add(new AccountRoute());
        me.add(new ItemRoute());
        me.add(new OrderRoute());
    }

    public void configEngine(Engine engine) {}

    public static DruidPlugin getDruidPlugin(){
        return new DruidPlugin(p.get("jdbcUrl"),p.get("user"),p.get("password").trim());
    }
    public void configPlugin(Plugins me) {
        /* 加载连接池 */
        DruidPlugin dp = getDruidPlugin();
        wallFilter = new WallFilter();
        wallFilter.setDbType("mysql");
        dp.addFilter(wallFilter);
        dp.addFilter(new StatFilter());
        me.add(dp);

        /* 加载ARP */
         ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
       _MappingKit.mapping(arp);//加载所有表映射
          //显示sql
        arp.setShowSql(true);
        me.add(arp);
        me.add(new EhCachePlugin());
        me.add(new Cron4jPlugin());
    }

    public void configInterceptor(Interceptors interceptors) {

    }

    public void configHandler(Handlers handlers) {

    }

    /**
     * 本方法会在 jfinal 启动过程完成之后被回调，详见 jfinal 手册
     */
    public void afterJFinalStart() {
        // 让 druid 允许在 sql 中使用 union
        // https://github.com/alibaba/druid/wiki/%E9%85%8D%E7%BD%AE-wallfilter
        wallFilter.getConfig().setSelectUnionCheck(false);
    }
}
