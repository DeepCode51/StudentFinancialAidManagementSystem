package com.fh.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/** 
 * 说明：日志处理
 * 创建人：FH Q313596790
 * 修改时间：2014年9月20日
 * @version
 */
public class FHLogger {


	static Logger logger = LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);
	
	/**
	 * 构造方法，初始化Log4j的日志对象
	 */
	private FHLogger(Logger log4jLogger) {
		logger = log4jLogger;
	}

	/**
	 * 获取构造器，根据类初始化Logger对象
	 * 
	 * @param Class 对象
	 * @return Logger对象
	 */
	public static FHLogger getLogger(Class classObject) {
		return new FHLogger(LogManager.getLogger(classObject));
	}

	/**
	 * 获取构造器，根据类名初始化Logger对象
	 * 
	 * @param String
	 *            类名字符串
	 * @return Logger对象
	 */
	public static FHLogger getLogger(String loggerName) {
		return new FHLogger(LogManager.getLogger(loggerName));
	}

	public void debug(Object object) {
		logger.debug(object);
	}

	public void debug(Object object, Throwable e) {
		logger.debug(object, e);
	}

	public void info(Object object) {
		logger.info(object);
	}

	public void info(Object object, Throwable e) {
		logger.info(object, e);
	}

	public void warn(Object object) {
		logger.warn(object);
	}

	public void warn(Object object, Throwable e) {
		logger.warn(object, e);
	}

	public void error(Object object) {
		logger.error(object);
	}

	public void error(Object object, Throwable e) {
		logger.error(object, e);
	}

	public void fatal(Object object) {
		logger.fatal(object);
	}

	public String getName() {
		return logger.getName();
	}

	public Logger getLog4jLogger() {
		return logger;
	}

}