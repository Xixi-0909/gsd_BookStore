// 全局变量：存储4位数字验证码，供校验使用
var randomCode = "";

// 页面加载完成后执行：初始化验证码+填充记住的用户名密码
window.onload = function() {
    createCode(); // 生成初始验证码
    loadRememberInfo(); // 加载本地缓存的用户名密码
    initRealTimeCheck(); // 初始化输入框实时校验（提升体验）
};

// 核心：表单整体校验函数（含实验要求+完备校验），提交时调用
function checkForm() {
    // 获取所有输入值，去除首尾空格（避免空格导致校验错误）
    var email = document.getElementById("email").value.trim();
    var username = document.getElementById("username").value.trim();
    var pwd = document.getElementById("pwd").value.trim();
    var repwd = document.getElementById("repwd").value.trim();
    var phone = document.getElementById("phone").value.trim();
    var code = document.getElementById("code").value.trim();
    var intro = document.getElementById("intro").value.trim();
    var remember = document.getElementById("remember").checked;
    // 校验结果初始化，默认通过
    var isOk = true;

    // 1. 邮箱校验：非空+合法格式（xxx@xxx.xxx）
    if (email === "") {
        setTip("emailTip", "邮箱不能为空！");
        isOk = false;
    } else if (!/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(email)) {
        setTip("emailTip", "请输入有效的邮箱地址！");
        isOk = false;
    } else {
        setTip("emailTip", "");
    }

    // 2. 用户名校验：实验核心要求（非空+1-10位+字母数字下划线+不能数字开头）
    if (username === "") {
        setTip("userTip", "用户名不能为空！");
        isOk = false;
    } else if (!/^[a-zA-Z_][a-zA-Z0-9_]{0,9}$/.test(username)) {
        setTip("userTip", "用户名格式错误！");
        isOk = false;
    } else {
        setTip("userTip", "");
    }

    // 3. 密码校验：实验要求（非空+6-16位字符）
    if (pwd === "") {
        setTip("pwdTip", "密码不能为空！");
        isOk = false;
    } else if (pwd.length < 6 || pwd.length > 16) {
        setTip("pwdTip", "密码请设置6-16位字符！");
        isOk = false;
    } else {
        setTip("pwdTip", "");
    }

    // 4. 重复密码校验：非空+与原密码一致
    if (repwd === "") {
        setTip("repwdTip", "请再次输入密码！");
        isOk = false;
    } else if (repwd !== pwd) {
        setTip("repwdTip", "两次输入的密码不一致！");
        isOk = false;
    } else {
        setTip("repwdTip", "");
    }

    // 5. 联系电话校验：非空+11位有效手机号（13-19开头）
    if (phone === "") {
        setTip("phoneTip", "联系电话不能为空！");
        isOk = false;
    } else if (!/^1[3-9]\d{9}$/.test(phone)) {
        setTip("phoneTip", "请输入11位有效手机号！");
        isOk = false;
    } else {
        setTip("phoneTip", "");
    }

    // 6. 验证码校验：扩展功能1（非空+与生成的验证码一致）
    if (code === "") {
        setTip("codeTip", "请输入验证码！");
        isOk = false;
    } else if (code !== randomCode) {
        setTip("codeTip", "验证码错误！");
        createCode(); // 验证码错误后重新生成
        isOk = false;
    } else {
        setTip("codeTip", "");
    }

    // 7. 个人介绍校验：完备校验（非空，扩展功能3）
    if (intro === "") {
        setTip("introTip", "个人介绍不能为空！");
        isOk = false;
    } else if (intro.length > 200) {
        setTip("introTip", "个人介绍不能超过200字！");
        isOk = false;
    } else {
        setTip("introTip", "");
    }

    // 8. 记住用户名密码：扩展功能2（校验通过后缓存到本地）
    if (isOk) {
        if (remember) {
            // 本地缓存，关闭浏览器后仍保留
            localStorage.setItem("bookstore_email", email);
            localStorage.setItem("bookstore_user", username);
            localStorage.setItem("bookstore_pwd", pwd);
        } else {
            // 取消记住，清除本地缓存
            localStorage.removeItem("bookstore_email");
            localStorage.removeItem("bookstore_user");
            localStorage.removeItem("bookstore_pwd");
        }
        // 校验通过，弹出成功提示
        alert("注册信息校验通过，即将提交！");
    }

    // 返回校验结果：true提交表单，false阻止提交
    return isOk;
}

// 封装提示文字设置函数：简化代码，根据ID设置提示内容
function setTip(tipId, content) {
    document.getElementById(tipId).innerText = content;
}

// 扩展功能1：生成4位随机数字验证码，点击验证码盒子可刷新
function createCode() {
    randomCode = "";
    var codeNum = [0,1,2,3,4,5,6,7,8,9]; // 数字验证码池
    for (var i=0; i<4; i++) {
        // 随机获取验证码池中的数字
        var randomIndex = Math.floor(Math.random() * 10);
        randomCode += codeNum[randomIndex];
    }
    // 将验证码显示在盒子中
    document.getElementById("codeBox").innerText = randomCode;
}

// 扩展功能2：加载本地缓存的用户名密码，填充到输入框
function loadRememberInfo() {
    var email = localStorage.getItem("bookstore_email");
    var user = localStorage.getItem("bookstore_user");
    var pwd = localStorage.getItem("bookstore_pwd");
    // 若有缓存，填充到对应输入框
    if (email) document.getElementById("email").value = email;
    if (user) document.getElementById("username").value = user;
    if (pwd) document.getElementById("pwd").value = pwd;
    // 若有缓存，自动勾选“记住用户名和密码”
    if (email && user && pwd) document.getElementById("remember").checked = true;
}

// 可选优化：输入框实时校验，输入时即时提示错误（提升用户体验）
function initRealTimeCheck() {
    // 邮箱实时校验
    document.getElementById("email").oninput = function() {
        if (this.value.trim() && !/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(this.value.trim())) {
            setTip("emailTip", "请输入有效的邮箱地址！");
        } else {
            setTip("emailTip", "");
        }
    };
    // 用户名实时校验
    document.getElementById("username").oninput = function() {
        if (this.value.trim() && !/^[a-zA-Z_][a-zA-Z0-9_]{0,9}$/.test(this.value.trim())) {
            setTip("userTip", "用户名格式错误！");
        } else {
            setTip("userTip", "");
        }
    };
    // 手机号实时校验
    document.getElementById("phone").oninput = function() {
        if (this.value.trim() && !/^1[3-9]\d{9}$/.test(this.value.trim())) {
            setTip("phoneTip", "请输入11位有效手机号！");
        } else {
            setTip("phoneTip", "");
        }
    };
}