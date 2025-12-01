# CTFd-Whale (Modified)

## [中文 README](README.zh-cn.md)

A plugin that empowers CTFd to bring up separate environments for each user

**This is a modified version with enhanced configuration options and improved stability.**

## 🆕 What's New in This Fork

### Configurable Frequency Limit

- **Customizable request frequency**: Changed from hardcoded 60 seconds to configurable limit (default: 10 seconds)
- **Dynamic configuration**: Frequency limit can be adjusted via CTFd admin panel without code changes
- **Better user experience**: More flexible rate limiting for container operations

### Enhanced FRP Router

- **Improved timeout handling**: Added 2-second timeout to FRP availability checks to prevent hanging
- **Better error handling**: More robust connection handling for FRP admin API
- **Stability improvements**: Prevents indefinite waits when FRP service is unresponsive

### Updated Dependencies

- **Modern package versions**: Updated to latest compatible versions
- **Security improvements**: Using newer, more secure package versions
- **Better compatibility**: Improved compatibility with recent CTFd versions

## 📋 Detailed Changes

### 1. Configurable Frequency Limit (`decorators.py`)

**Before:**

```python
if int(time.time()) - session["limit"] < 60:
    abort(403, 'Frequency limit, You should wait at least 1 min.', success=False)
```

**After:**

```python
frequency_limit = int(get_config("whale:frequency_limit", "10"))
if int(time.time()) - session["limit"] < frequency_limit:
    abort(403, f'Frequency limit, You should wait at least {frequency_limit} seconds.', success=False)
```

**Benefits:**

- Admins can adjust frequency limit via config: `whale:frequency_limit`
- Default changed from 60 seconds to 10 seconds for better UX
- Dynamic error messages show actual wait time
- No code changes needed to adjust rate limiting

### 2. FRP Availability Check Timeout (`utils/routers/frp.py`)

**Before:**

```python
resp = self.ses.get(f'{self.url}/api/status')
```

**After:**

```python
resp = self.ses.get(f'{self.url}/api/status', timeout=2.0)
```

**Benefits:**

- Prevents hanging when FRP service is unresponsive
- 2-second timeout ensures quick failure detection
- Better error handling and user feedback
- Improved overall system stability

### 3. Default Configuration (`utils/setup.py`)

**Added:**

```python
'frequency_limit': '10',
```

**Benefits:**

- Explicit default configuration for frequency limit
- Consistent with other whale configuration options
- Easy to discover and modify via admin panel

### 4. Updated Dependencies (`requirements.txt`)

**Updated packages:**

```
docker[tls]>=7.0.0
Flask-APScheduler==1.11.0
flask-redis==0.4.0
redis==3.3.11
```

**Benefits:**

- Modern, secure package versions
- Better compatibility with recent Python versions
- Improved stability and performance

## 🚀 Features

- Deploys containers with `frp` and `docker swarm`
- Supports subdomain access by utilizing `frp`
- Contestants can start/renew/destroy their environments with a single click
- Flags and subdomains are generated automatically with configurable rules
- Administrators can get a full list of running containers, with full control over them
- **NEW:** Configurable frequency limits for container operations
- **NEW:** Improved timeout handling for FRP connections

## 📦 Installation & Usage

Refer to [installation guide](docs/install.md)

## ⚙️ Configuration

### Frequency Limit Configuration

You can configure the frequency limit in the CTFd admin panel:

1. Go to **Admin Panel** → **Config** → **Settings**
2. Add or modify the config key: `whale:frequency_limit`
3. Set the value in seconds (default: `10`)

**Example values:**

- `10` - Users must wait 10 seconds between container operations (default)
- `30` - Users must wait 30 seconds between operations
- `60` - Users must wait 1 minute between operations (original behavior)

### FRP Configuration

The FRP router now includes timeout protection:

- API status checks timeout after 2 seconds
- Prevents system hangs when FRP is unresponsive
- Provides clear error messages for troubleshooting

## 🔧 Technical Details

### Modified Files

1. **`decorators.py`**

   - Added configurable frequency limit
   - Dynamic error messages
   - Reads from CTFd config system

2. **`utils/routers/frp.py`**

   - Added 2-second timeout to FRP availability checks
   - Improved error handling for RequestException
   - Better connection stability

3. **`utils/setup.py`**

   - Added `frequency_limit` to default configs
   - Set default value to 10 seconds

4. **`requirements.txt`**
   - Updated package versions
   - Improved security and compatibility

## 📸 Screenshots

![](https://user-images.githubusercontent.com/20221896/105939593-7cca6f80-6094-11eb-92de-8a04554dc019.png)

![image](https://user-images.githubusercontent.com/20221896/105940182-a637cb00-6095-11eb-9525-8291986520c1.png)

![](https://user-images.githubusercontent.com/20221896/105939965-2e69a080-6095-11eb-9b31-7777a0cc41b9.png)

![](https://user-images.githubusercontent.com/20221896/105940026-50632300-6095-11eb-8512-6f19dd12c776.png)

## 🔗 Original Project

This is a fork of [CTFd-Whale](https://github.com/frankli0324/ctfd-whale) with enhancements for production use.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

See [LICENSE](LICENSE) file for details.

## 🌟 Demo

[BUUCTF](https://buuoj.cn)

## 📚 Third-party Introductions (zh-CN)

- [CTFd-Whale 推荐部署实践](https://www.zhaoj.in/read-6333.html)
- [手把手教你如何建立一个支持 ctf 动态独立靶机的靶场（ctfd+ctfd-whale)](https://blog.csdn.net/fjh1997/article/details/100850756)

## 🔗 Related Projects

- [CTFd-Owl](https://github.com/D0g3-Lab/H1ve/tree/master/CTFd/plugins/ctfd-owl) (支持部署 compose)

---

## 📋 Changelog

### 2024-12-01 (This Fork)

- ✨ Added configurable frequency limit (default: 10 seconds)
- 🔧 Added timeout to FRP availability checks (2 seconds)
- 📦 Updated dependencies to latest versions
- 🐛 Improved error handling and stability
- 📝 Enhanced documentation

### 2020-03-18

- Allow non-dynamic flag

### 2020-02-18

- Refine front for ctfd newer version (@frankli0324)

### 2019-11-21

- Add network prefix & timeout setting
- Refine port and network range search
- Refine frp request
- Refine lock timeout

For full changelog, see [CHANGELOG.md](CHANGELOG.md)
