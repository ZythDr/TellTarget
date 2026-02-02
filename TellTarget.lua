-- TellTarget - Vanilla WoW 1.12.1

SLASH_TELLTARGET1 = "/tt";

SlashCmdList["TELLTARGET"] = function(msg)
msg = msg or "";
msg = string.gsub(msg, "^%s+", "");

if msg == "" then
    DEFAULT_CHAT_FRAME:AddMessage("|cffff8080Usage: /tt <message>|r");
return;
end

if not UnitExists("target") or UnitIsPlayer("target") ~= 1 then
    DEFAULT_CHAT_FRAME:AddMessage("|cffff8080TellTarget: Invalid target.|r");
return;
end

local name = UnitName("target");
SendChatMessage(msg, "WHISPER", nil, name);
end

local replacing = false;

local function TellTarget_EditBox_OnTextChanged()
if replacing then return; end

    local text = ChatFrameEditBox:GetText();
if not text then return; end

    -- Detect "/tt " exactly
    if string.sub(text, 1, 4) == "/tt " then
        if UnitExists("target") and UnitIsPlayer("target") == 1 then
            local name = UnitName("target");
        if name and name ~= "" then
            replacing = true;
        ChatFrameEditBox:SetText("/w " .. name .. " ");
    -- Vanilla 1.12 doesn't have SetCursorPosition (added later), so guard it
    if ChatFrameEditBox.SetCursorPosition then
        ChatFrameEditBox:SetCursorPosition(string.len(ChatFrameEditBox:GetText()));
    end

replacing = false;
end
end
end
end

-- Hook the chat edit box (Vanilla-safe)
local original_OnTextChanged = ChatFrameEditBox:GetScript("OnTextChanged");

ChatFrameEditBox:SetScript("OnTextChanged", function(...)
if original_OnTextChanged then
    original_OnTextChanged(unpack(arg));
end
TellTarget_EditBox_OnTextChanged();
end);
