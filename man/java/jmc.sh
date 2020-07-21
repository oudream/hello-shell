#!/usr/bin/env bash

### -XX:+UnlockCommercialFeatures -XX:+FlightRecorder
#飞行记录器功能。要启用此功能, 必须使用通过 -XX:+UnlockCommercialFeatures -XX:+FlightRecorder 启动的 Java 7u4 或更高版本的 JVM。
#	at com.jrockit.mc.flightrecorder.controlpanel.ui.FlightRecorderProvider.refreshRecordings(FlightRecorderProvider.java:124)
#	at com.jrockit.mc.flightrecorder.controlpanel.ui.FlightRecorderProvider.refresh(FlightRecorderProvider.java:99)
#	... 8 more
