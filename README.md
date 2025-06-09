## 📝 DigitalOcean Spaces Sync Script – README

This script allows you to **upload** or **download** folders to/from a [DigitalOcean Spaces](https://docs.digitalocean.com/products/spaces/) bucket using the AWS CLI (can be used for any S3 compatible object storage).

---

### ✅ Prerequisites

Before using the script, ensure the following tools and credentials are properly set up.

---

### 1. 🛠 Install AWS CLI

**On Ubuntu/Debian:**

```bash
sudo apt update
sudo apt install awscli -y
```

**On macOS (using Homebrew):**

```bash
brew install awscli
```

**On Windows:**

* Download the installer from [https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)
* Follow the on-screen instructions.

To verify installation:

```bash
aws --version
```

---

### 2. 🔐 Get DigitalOcean Spaces Access Keys

* Log in to your [DigitalOcean Control Panel](https://cloud.digitalocean.com/)
* Navigate to **Spaces** > **API**
* Click **Generate New Key**
* Save the **Access Key** and **Secret Key**

---

### 3. ⚙️ Configure AWS CLI for DigitalOcean

Run the following command:

```bash
aws configure
```

Then enter:

* **AWS Access Key ID** → DigitalOcean Spaces **Access Key**
* **AWS Secret Access Key** → DigitalOcean Spaces **Secret Key**
* **Default region name** → `us-east-1` *(arbitrary but required)*
* **Default output format** → `json` *(or leave blank)*

> 🧠 This config is saved in `~/.aws/credentials` and used by the script.

---

### 4. 🌍 Supported DigitalOcean Region Endpoints

| Region | Endpoint                      |
| ------ | ----------------------------- |
| NYC3   | `nyc3.digitaloceanspaces.com` |
| SFO2   | `sfo2.digitaloceanspaces.com` |
| AMS3   | `ams3.digitaloceanspaces.com` |
| BLR1   | `blr1.digitaloceanspaces.com` |
| FRA1   | `fra1.digitaloceanspaces.com` |

---

### 🚀 Usage

1. Ensure the script (`do_space_sync.sh`) is executable:

   ```bash
   chmod +x script_sync.sh
   ```

2. Run the script with `upload` or `download`:

   ```bash
   ./script_sync.sh upload
   ./script_sync.sh download
   ```

3. Follow the interactive prompts:

   * Enter the **bucket name**
   * Enter the **local folder path**
   * Enter the **DigitalOcean region endpoint** (e.g., `blr1.digitaloceanspaces.com`)

---

### 📦 Example

```bash
./script_sync.sh upload
# Prompts:
#   > Bucket Name: docker-images
#   > Local Folder: ./docker_images
#   > Region Endpoint: blr1.digitaloceanspaces.com
```

---

### 🧪 Troubleshooting

* **Access Denied?**

  * Check your key/secret and permissions.
* **Invalid endpoint?**

  * Ensure the correct region endpoint is used.
* **Sync command not found?**

  * Ensure AWS CLI is correctly installed and on the PATH.

