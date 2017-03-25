package com.maiseries.core.bank.web.common.util;

/**
 */
public class ResponseJsonBean {
    private boolean success;
    private String msg;
    private Object data;

    public boolean getSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "ResponseJsonBean [success=" + success + ", msg=" + msg + ", data=" + data + "]";
    }

}
