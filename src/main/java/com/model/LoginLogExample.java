package com.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class LoginLogExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public LoginLogExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Integer value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Integer value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Integer value1, Integer value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Integer value1, Integer value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andLoginnameIsNull() {
            addCriterion("loginName is null");
            return (Criteria) this;
        }

        public Criteria andLoginnameIsNotNull() {
            addCriterion("loginName is not null");
            return (Criteria) this;
        }

        public Criteria andLoginnameEqualTo(String value) {
            addCriterion("loginName =", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameNotEqualTo(String value) {
            addCriterion("loginName <>", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameGreaterThan(String value) {
            addCriterion("loginName >", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameGreaterThanOrEqualTo(String value) {
            addCriterion("loginName >=", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameLessThan(String value) {
            addCriterion("loginName <", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameLessThanOrEqualTo(String value) {
            addCriterion("loginName <=", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameLike(String value) {
            addCriterion("loginName like", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameNotLike(String value) {
            addCriterion("loginName not like", value, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameIn(List<String> values) {
            addCriterion("loginName in", values, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameNotIn(List<String> values) {
            addCriterion("loginName not in", values, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameBetween(String value1, String value2) {
            addCriterion("loginName between", value1, value2, "loginname");
            return (Criteria) this;
        }

        public Criteria andLoginnameNotBetween(String value1, String value2) {
            addCriterion("loginName not between", value1, value2, "loginname");
            return (Criteria) this;
        }

        public Criteria andLogindateIsNull() {
            addCriterion("loginDate is null");
            return (Criteria) this;
        }

        public Criteria andLogindateIsNotNull() {
            addCriterion("loginDate is not null");
            return (Criteria) this;
        }

        public Criteria andLogindateEqualTo(Date value) {
            addCriterion("loginDate =", value, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateNotEqualTo(Date value) {
            addCriterion("loginDate <>", value, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateGreaterThan(Date value) {
            addCriterion("loginDate >", value, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateGreaterThanOrEqualTo(Date value) {
            addCriterion("loginDate >=", value, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateLessThan(Date value) {
            addCriterion("loginDate <", value, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateLessThanOrEqualTo(Date value) {
            addCriterion("loginDate <=", value, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateIn(List<Date> values) {
            addCriterion("loginDate in", values, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateNotIn(List<Date> values) {
            addCriterion("loginDate not in", values, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateBetween(Date value1, Date value2) {
            addCriterion("loginDate between", value1, value2, "logindate");
            return (Criteria) this;
        }

        public Criteria andLogindateNotBetween(Date value1, Date value2) {
            addCriterion("loginDate not between", value1, value2, "logindate");
            return (Criteria) this;
        }

        public Criteria andLoginipIsNull() {
            addCriterion("loginIp is null");
            return (Criteria) this;
        }

        public Criteria andLoginipIsNotNull() {
            addCriterion("loginIp is not null");
            return (Criteria) this;
        }

        public Criteria andLoginipEqualTo(String value) {
            addCriterion("loginIp =", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipNotEqualTo(String value) {
            addCriterion("loginIp <>", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipGreaterThan(String value) {
            addCriterion("loginIp >", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipGreaterThanOrEqualTo(String value) {
            addCriterion("loginIp >=", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipLessThan(String value) {
            addCriterion("loginIp <", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipLessThanOrEqualTo(String value) {
            addCriterion("loginIp <=", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipLike(String value) {
            addCriterion("loginIp like", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipNotLike(String value) {
            addCriterion("loginIp not like", value, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipIn(List<String> values) {
            addCriterion("loginIp in", values, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipNotIn(List<String> values) {
            addCriterion("loginIp not in", values, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipBetween(String value1, String value2) {
            addCriterion("loginIp between", value1, value2, "loginip");
            return (Criteria) this;
        }

        public Criteria andLoginipNotBetween(String value1, String value2) {
            addCriterion("loginIp not between", value1, value2, "loginip");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}