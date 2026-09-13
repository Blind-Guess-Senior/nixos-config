{ config, ... }:

{
  services.movie-pool = {
    enable = true;
    address = "0.0.0.0";
    port = 8086;
    openFirewall = true;

    # 下面全是默认值，列出来只是让你知道有什么可调
    # period      = "168h";         # 一个阶段多长，每阶段最多抽一次
    # drawWeekday = "wed";          # 抽签在星期几
    # drawTime    = "20:00";        # 抽签在几点（服务本地时区）
    # limit       = 2;              # 每人每周期最多提交几部
    # siteTitle   = "今天看什么";
    # timeZone    = "Asia/Shanghai"; # 不写就用系统时区
  };
}
