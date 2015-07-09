package com.greeningtree.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Modifier;
import java.util.Arrays;

public class Print {
	private static final int DEPTH = 2;
	public static void print(Object obj) {
		System.out.println(smartString() + getString(obj) + "\r\n");
	}

	public static void print() {
		System.out.println(smartString());
	}

	/**
	 * @param key
	 * @param v
	 */
	public static void print(Object key, Object v) {
		System.out.print(smartString() + getString(key));
		System.out.print(" : ");
		System.out.print(getString(v) + "\r\n\r\n");
	}

	public static void printReflect(Object obj) {
		System.out.print(smartString());
		if (obj == null) {
			System.out.println("null");
			return;
		}
		Class<?> cls = obj.getClass();
		for (Field field : cls.getDeclaredFields()) {
			int mod = field.getModifiers();
			if (Modifier.isStatic(mod) || Modifier.isTransient(mod)) {
				continue;
			}
			Object value = null;
			char[] methodName = field.getName().toCharArray();
			methodName[0] -= 32;
			try {
				value = cls.getMethod("get" + String.valueOf(methodName))
				.invoke(obj);
			} catch (IllegalArgumentException e) {
				field.setAccessible(true);
				try {
					value = field.get(obj);
				} catch (IllegalArgumentException e1) {
					e1.printStackTrace();
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			} catch (SecurityException e) {
				field.setAccessible(true);
				try {
					value = field.get(obj);
				} catch (IllegalArgumentException e1) {
					e1.printStackTrace();
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			} catch (IllegalAccessException e) {
				field.setAccessible(true);
				try {
					value = field.get(obj);
				} catch (IllegalArgumentException e1) {
					e1.printStackTrace();
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			} catch (InvocationTargetException e) {
				field.setAccessible(true);
				try {
					value = field.get(obj);
				} catch (IllegalArgumentException e1) {
					e1.printStackTrace();
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			} catch (NoSuchMethodException e) {
				field.setAccessible(true);
				try {
					value = field.get(obj);
				} catch (IllegalArgumentException e1) {
					e1.printStackTrace();
				} catch (IllegalAccessException e1) {
					e1.printStackTrace();
				}
			}
			System.out.println(field.getName() + " : " + getString(value));
		}
		System.out.println("");
	}

	public static void print(Object... objs) {
		if (objs == null) {
			System.out.println(smartString() + "null");
			return;
		} else if (objs.length == 0) {
			System.out.println(smartString() + "[]");
		} else {
			StringBuilder sb = new StringBuilder();
			sb.append('[');
			for (int i = 0; i < objs.length - 1; i++) {
				sb.append(getString(objs[i])).append(',').append(' ');
			}
			sb.append(getString(objs[objs.length - 1])).append(']');
			System.out.println(smartString() + sb);
		}
	}

	@Deprecated
	static String newLine() {
		return System.getProperty("line.separator", "/n");
	}

	private static String smartString() {
		return new Throwable().getStackTrace()[DEPTH].toString() + "\r\n";
	}

	private static String getString(Object obj) {
		if (obj == null)
			return "null";
		if (obj.getClass().isArray()) {
			if (obj instanceof Object[])
				return Arrays.toString((Object[]) obj);
			if (obj instanceof byte[])
				return Arrays.toString((byte[]) obj);
			if (obj instanceof char[])
				return Arrays.toString((char[]) obj);
			if (obj instanceof int[])
				return Arrays.toString((int[]) obj);
			if (obj instanceof double[])
				return Arrays.toString((double[]) obj);
			if (obj instanceof short[])
				return Arrays.toString((short[]) obj);
			if (obj instanceof long[])
				return Arrays.toString((long[]) obj);
			if (obj instanceof float[])
				return Arrays.toString((float[]) obj);
			if (obj instanceof boolean[])
				return Arrays.toString((boolean[]) obj);
		}
		return obj.toString();
	}
	
}
