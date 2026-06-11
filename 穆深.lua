function nc_offset(addr,tablex,tt) for i,v in ipairs(tablex) do if v[4]==true then gg.addListItems({{address=addr+v[3],flags=v[2],value=v[1],freeze=v[4]}})else gg.setValues({{address=addr+v[3],flags=v[2],value=v[1]}}) end end gg.toast((tt or "").."开启成功") end
function getso(So_name) return gg.getRangesList(So_name)[1].start end

function BaAdd(add) t=gg.getValues({[1]={address=add,flags=4}}) return t[1].value&0xFFFFFFFF end
function readPointer(Add,Item) for i=1,(#Item-1) do Add=BaAdd(Add+Item[i]) end return Add+Item[#Item] end
function setvalue(add,value,falgs,dj) local WY={} WY[1]={} WY[1].address=add WY[1].value=value WY[1].flags=falgs if dj==true then WY[1].freeze=true gg.addListItems(WY) else gg.setValues(WY) end end
function getnc(Name,nc) local t=gg.getRangesList(Name) for i, v in ipairs(t) do if v.state==nc then return v.start end end end

function SearchWrite(Search, Write, Type)
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber(Search[1][1], Type)
    local count = gg.getResultCount()
    local result = gg.getResults(count)
    gg.clearResults()
    local data = {} 
    local base = Search[1][2] 
    
   if (count > 0) then
        for i, v in ipairs(result) do
            v.isUseful = true 
        end
        
        for k=2, #Search do
            local tmp = {}
            local offset = Search[k][2] - base 
            local num = Search[k][1] 
            
            for i, v in ipairs(result) do
                tmp[#tmp+1] = {} 
                tmp[#tmp].address = v.address + offset  
                tmp[#tmp].flags = v.flags  
            end
            
            tmp = gg.getValues(tmp) 
            
            for i, v in ipairs(tmp) do
                if ( tostring(v.value) ~= tostring(num) ) then 
                    result[i].isUseful = false 
                end
            end
        end
          for i, v in ipairs(result) do
            if (v.isUseful) then 
                data[#data+1] = v.address
            end
        end
        
        if (#data > 0) then
           gg.toast("\n共修改"..#data.."条数据")
           local t = {}
           local base = Search[1][2]
           for i=1, #data do
               for k, w in ipairs(Write) do
                   offset = w[2] - base
                   t[#t+1] = {}
                   t[#t].address = data[i] + offset
                   t[#t].flags = Type
                   t[#t].value = w[1]
                   
                   if (w[3] == true) then
                       local item = {}
                       item[#item+1] = t[#t]
                       item[#item].freeze = true
                       gg.addListItems(item)
                   end
                   
               end
           end
           gg.setValues(t)
        else
            gg.toast("\n开启失败，没有数据", false)
            return false
        end
    else
        gg.toast("\n开启失败，没有数据")
        return false
    end
end

function split(szFullString, szSeparator) local nFindStartIndex = 1 local nSplitIndex = 1 local nSplitArray = {} while true do local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex) if not nFindLastIndex then nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString)) break end nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1) nFindStartIndex = nFindLastIndex + string.len(szSeparator) nSplitIndex = nSplitIndex + 1 end return nSplitArray end function xgxc(szpy, qmxg) for x = 1, #(qmxg) do xgpy = szpy + qmxg[x]["offset"] xglx = qmxg[x]["type"] xgsz = qmxg[x]["value"] gg.setValues({[1] = {address = xgpy, flags = xglx, value = xgsz}}) xgsl = xgsl + 1 end end function xqmnb(qmnb) gg.clearResults() gg.setRanges(qmnb[1]["memory"]) gg.searchNumber(qmnb[3]["value"], qmnb[3]["type"]) if gg.getResultCount() == 0 then gg.toast(qmnb[2]["name"] .. "\n开启失败") else gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) if gg.getResultCount() == 0 then gg.toast(qmnb[2]["name"] .. "\n开启失败") else sl = gg.getResults(999999) sz = gg.getResultCount() xgsl = 0 if sz > 999999 then sz = 999999 end for i = 1, sz do pdsz = true for v = 4, #(qmnb) do if pdsz == true then pysz = {} pysz[1] = {} pysz[1].address = sl[i].address + qmnb[v]["offset"] pysz[1].flags = qmnb[v]["type"] szpy = gg.getValues(pysz) pdpd = qmnb[v]["lv"] .. ";" .. szpy[1].value szpd = split(pdpd, ";") tzszpd = szpd[1] pyszpd = szpd[2] if tzszpd == pyszpd then pdjg = true pdsz = true else pdjg = false pdsz = false end end end if pdjg == true then szpy = sl[i].address xgxc(szpy, qmxg) xgjg = true end end if xgjg == true then gg.toast(qmnb[2]["name"] .. "\n开启成功\n共修改" .. xgsl .. "\n条数据") else gg.toast(qmnb[2]["name"] .. "\n开启失败") end end end end

DWORD=gg.TYPE_DWORD  DOUBLE=gg.TYPE_DOUBLE  FLOAT=gg.TYPE_FLOAT WORD=gg.TYPE_WORD BYTE=gg.TYPE_BYTE XOR=gg.TYPE_XOR QWORD=gg.TYPE_QWORD
-- 【【 核心代码，不懂勿动 】】
--   JF Script编辑器



function SearchWrite(Search, Write, Type) gg.clearResults() gg.setVisible(false) gg.searchNumber(Search[1][1], Type) local count = gg.getResultCount() local result = gg.getResults(count) gg.clearResults() local data = {} local base = Search[1][2] if (count > 0) then for i, v in ipairs(result) do v.isUseful = true end for k=2, #Search do local tmp = {} local offset = Search[k][2] - base local num = Search[k][1] for i, v in ipairs(result) do tmp[#tmp+1] = {} tmp[#tmp].address = v.address + offset tmp[#tmp].flags = v.flags end tmp = gg.getValues(tmp) for i, v in ipairs(tmp) do if ( tostring(v.value) ~= tostring(num) ) then result[i].isUseful = false end end end for i, v in ipairs(result) do if (v.isUseful) then data[#data+1] = v.address end end if (#data > 0) then gg.toast(Name.."  修改"..#data.."条数据") local t = {} local base = Search[1][2] for i=1, #data do for k, w in ipairs(Write) do offset = w[2] - base t[#t+1] = {} t[#t].address = data[i] + offset t[#t].flags = Type t[#t].value = w[1] if (w[3] == true) then local item = {} item[#item+1] = t[#t] item[#item].freeze = true gg.addListItems(item)end end end gg.setValues(t) else gg.toast(Name.."   开启失败", false) return false end else gg.toast(Name.."   开启失败") return false end end function split(szFullString, szSeparator) local nFindStartIndex = 1 local nSplitIndex = 1 local nSplitArray = {} 
            while true do
                while a2jNIWsBYQwjdw1M < os.time() do
                    gg.alert('脚本已过期')
                    os.exit()
                end
                while check == nil do
                    os.exit()
                end
                while checktrue ~= (imei .. a7eTyrOdTgglZkZU.user_time .. api_time..xxxxxxx_11818..wig_code) do
                    os.exit()
                end
        
        
         local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex) if not nFindLastIndex then nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString)) break end nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1) nFindStartIndex = nFindLastIndex + string.len(szSeparator) nSplitIndex = nSplitIndex + 1 end return nSplitArray end function xgxc(szpy, qmxg) for x = 1, #(qmxg) do xgpy = szpy + qmxg[x]["offset"] xglx = qmxg[x]["type"] xgsz = qmxg[x]["value"] gg.setValues({[1] = {address = xgpy, flags = xglx, value = xgsz}}) xgsl = xgsl + 1 end end function xqmnb(qmnb) gg.clearResults() gg.setRanges(qmnb[1]["memory"]) gg.searchNumber(qmnb[3]["value"], qmnb[3]["type"]) if gg.getResultCount() == 0 then gg.toast(qmnb[2]["name"] .. "开启失败") else gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) if gg.getResultCount() == 0 then gg.toast(qmnb[2]["name"] .. "开启失败") else sl = gg.getResults(999999) sz = gg.getResultCount() xgsl = 0 if sz > 999999 then sz = 999999 end for i = 1, sz do pdsz = true for v = 4, #(qmnb) do if pdsz == true then pysz = {} pysz[1] = {} pysz[1].address = sl[i].address + qmnb[v]["offset"] pysz[1].flags = qmnb[v]["type"] szpy = gg.getValues(pysz) pdpd = qmnb[v]["lv"] .. ";" .. szpy[1].value szpd = split(pdpd, ";") tzszpd = szpd[1] pyszpd = szpd[2] if tzszpd == pyszpd then pdjg = true pdsz = true else pdjg = false pdsz = false end end end if pdjg == true then szpy = sl[i].address xgxc(szpy, qmxg) xgjg = true end end if xgjg == true then gg.toast(qmnb[2]["name"] .. "开启成功,共修改" .. xgsl .. "条ΔΘ") else gg.toast(qmnb[2]["name"] .. "开启失败") end end end end function PS() end function setvalue(address,flags,value) PS('修改地址数值(地址,数值类型,要修改的值)') local tt={} tt[1]={} tt[1].address=address tt[1].flags=flags tt[1].value=value gg.setValues(tt) end 


--仿xs配置不懂勿动
function SearchWrite(Search, Write, Type) gg.clearResults() gg.setVisible(false) gg.searchNumber(Search[1][1], Type) local count = gg.getResultCount() local result = gg.getResults(count) gg.clearResults() local data = {} local base = Search[1][2] if (count > 0) then for i, v in ipairs(result) do v.isUseful = true end for k=2, #Search do local tmp = {} local offset = Search[k][2] - base local num = Search[k][1] for i, v in ipairs(result) do tmp[#tmp+1] = {} tmp[#tmp].address = v.address + offset tmp[#tmp].flags = v.flags end tmp = gg.getValues(tmp) for i, v in ipairs(tmp) do if ( tostring(v.value) ~= tostring(num) ) then result[i].isUseful = false end end end for i, v in ipairs(result) do if (v.isUseful) then data[#data+1] = v.address end end if (#data > 0) then gg.toast("🕹:修改"..#data.."条数据.开启成功") local t = {} local base = Search[1][2] for i=1, #data do for k, w in ipairs(Write) do offset = w[2] - base t[#t+1] = {} t[#t].address = data[i] + offset t[#t].flags = Type t[#t].value = w[1] if (w[3] == true) then local item = {} item[#item+1] = t[#t] item[#item].freeze = true gg.addListItems(item) end end end gg.setValues(t) else gg.toast("🕹:搜索0条数据.修改失败", false) return false end else gg.toast("🕹:搜索0条数据.修改失败") return false end end
--指针配置不懂勿


DWORD=gg.TYPE_DWORD  DOUBLE=gg.TYPE_DOUBLE  FLOAT=gg.TYPE_FLOAT WORD=gg.TYPE_WORD BYTE=gg.TYPE_BYTE XOR=gg.TYPE_XOR QWORD=gg.TYPE_QWORD
-- 【【 核心代码，不懂勿动 】】
--   JF Script编辑器

function nc_offset(addr,tablex,tt) for i,v in ipairs(tablex) do if v[4]==true then gg.addListItems({{address=addr+v[3],flags=v[2],value=v[1],freeze=v[4]}})else gg.setValues({{address=addr+v[3],flags=v[2],value=v[1]}}) end end gg.toast((tt or "").."开启成功") end
function getso(So_name) return gg.getRangesList(So_name)[1].start end

function BaAdd(add) t=gg.getValues({[1]={address=add,flags=4}}) return t[1].value&0xFFFFFFFF end
function readPointer(Add,Item) for i=1,(#Item-1) do Add=BaAdd(Add+Item[i]) end return Add+Item[#Item] end
function setvalue(add,value,falgs,dj) local WY={} WY[1]={} WY[1].address=add WY[1].value=value WY[1].flags=falgs if dj==true then WY[1].freeze=true gg.addListItems(WY) else gg.setValues(WY) end end
function getnc(Name,nc) local t=gg.getRangesList(Name) for i, v in ipairs(t) do if v.state==nc then return v.start end end end

function SearchWrite(Search, Write, Type)
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber(Search[1][1], Type)
    local count = gg.getResultCount()
    local result = gg.getResults(count)
    gg.clearResults()
    local data = {} 
    local base = Search[1][2] 
    
   if (count > 0) then
        for i, v in ipairs(result) do
            v.isUseful = true 
        end
        
        for k=2, #Search do
            local tmp = {}
            local offset = Search[k][2] - base 
            local num = Search[k][1] 
            
            for i, v in ipairs(result) do
                tmp[#tmp+1] = {} 
                tmp[#tmp].address = v.address + offset  
                tmp[#tmp].flags = v.flags  
            end
            
            tmp = gg.getValues(tmp) 
            
            for i, v in ipairs(tmp) do
                if ( tostring(v.value) ~= tostring(num) ) then 
                    result[i].isUseful = false 
                end
            end
        end
          for i, v in ipairs(result) do
            if (v.isUseful) then 
                data[#data+1] = v.address
            end
        end
        
        if (#data > 0) then
           gg.toast("\n共修改"..#data.."条数据")
           local t = {}
           local base = Search[1][2]
           for i=1, #data do
               for k, w in ipairs(Write) do
                   offset = w[2] - base
                   t[#t+1] = {}
                   t[#t].address = data[i] + offset
                   t[#t].flags = Type
                   t[#t].value = w[1]
                   
                   if (w[3] == true) then
                       local item = {}
                       item[#item+1] = t[#t]
                       item[#item].freeze = true
                       gg.addListItems(item)
                   end
                   
               end
           end
           gg.setValues(t)
        else
            gg.toast("\n开启失败", false)
            return false
        end
    else
        gg.toast("\n开启失败")
        return false
    end
end

function split(szFullString, szSeparator) local nFindStartIndex = 1 local nSplitIndex = 1 local nSplitArray = {} while true do local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex) if not nFindLastIndex then nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString)) break end nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1) nFindStartIndex = nFindLastIndex + string.len(szSeparator) nSplitIndex = nSplitIndex + 1 end return nSplitArray end function xgxc(szpy, qmxg) for x = 1, #(qmxg) do xgpy = szpy + qmxg[x]["offset"] xglx = qmxg[x]["type"] xgsz = qmxg[x]["value"] gg.setValues({[1] = {address = xgpy, flags = xglx, value = xgsz}}) xgsl = xgsl + 1 end end function xqmnb(qmnb) gg.clearResults() gg.setRanges(qmnb[1]["memory"]) gg.searchNumber(qmnb[3]["value"], qmnb[3]["type"]) if gg.getResultCount() == 0 then gg.toast(qmnb[2]["name"] .. "\n开启失败") else gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) gg.refineNumber(qmnb[3]["value"], qmnb[3]["type"]) if gg.getResultCount() == 0 then gg.toast(qmnb[2]["name"] .. "\n开启失败") else sl = gg.getResults(999999) sz = gg.getResultCount() xgsl = 0 if sz > 999999 then sz = 999999 end for i = 1, sz do pdsz = true for v = 4, #(qmnb) do if pdsz == true then pysz = {} pysz[1] = {} pysz[1].address = sl[i].address + qmnb[v]["offset"] pysz[1].flags = qmnb[v]["type"] szpy = gg.getValues(pysz) pdpd = qmnb[v]["lv"] .. ";" .. szpy[1].value szpd = split(pdpd, ";") tzszpd = szpd[1] pyszpd = szpd[2] if tzszpd == pyszpd then pdjg = true pdsz = true else pdjg = false pdsz = false end end end if pdjg == true then szpy = sl[i].address xgxc(szpy, qmxg) xgjg = true end end if xgjg == true then gg.toast(qmnb[2]["name"] .. "\n开启成功\n共修改" .. xgsl .. "\n条数据") else gg.toast(qmnb[2]["name"] .. "\n开启失败") end end end end

DWORD=gg.TYPE_DWORD  DOUBLE=gg.TYPE_DOUBLE  FLOAT=gg.TYPE_FLOAT WORD=gg.TYPE_WORD BYTE=gg.TYPE_BYTE XOR=gg.TYPE_XOR QWORD=gg.TYPE_QWORD


local function LongTao(Search, Write)
  gg.clearResults()
  gg.setVisible(false)
  lx=Search[1]["类型"]
  gg.searchNumber(Search[1]["主特征码"], lx)
  local count = gg.getResultCount()
  local result = gg.getResults(count)
  gg.clearResults()
  local data = {}
  if (count > 0) then
    gg.toast("共搜索 "..count.." 条数据")
    for i, v in ipairs(result) do
      v.isUseful = true
    end
    for k=2, #Search do
      local tmp = {}
      local num = Search[k]["副特征码"]
      if Search[k]["类型"]~= nil then
           lx =Search[k]["类型"]
         else
           lx = Search[1]["类型"]
        end
      for i, v in ipairs(result) do
        tmp[#tmp+1] = {}
        tmp[#tmp].address = v.address + Search[k]["偏移"]
        tmp[#tmp].flags = lx
      end
      tmp = gg.getValues(tmp)
      for i, v in ipairs(tmp) do
        if ( tostring(v.value) ~= tostring(num) ) then
          result[i].isUseful = false
        end
      end
    end
    for i, v in ipairs(result) do
      if (v.isUseful) then
        data[#data+1] = v.address
      end
    end
    if (#data > 0) then
      local t = {}
      for i=1, #data do
        for k, w in ipairs(Write) do
          if w["类型"] ~= nil then
             lx = w["类型"]
           else
             lx = Search[1]["类型"]
          end
          t[#t+1] = {}
          t[#t].address = data[i] + w["偏移"]
          t[#t].flags = lx
          if (w["修改"]~=nil) and (w["修改"]~=false) then
            t[#t].value = w["修改"]
            gg.setValues(t)
            if (w["冻结"] == true) then
              local item = {}
              item[#item+1] = t[#t]
              item[#item].freeze = w["冻结"]
              gg.addListItems(item)
            end
          end
        end
      end
      gg.loadResults(t)
      gg.toast("共偏移 "..#t.." 条数据")
     else
      gg.toast("未搜到数据！")
      return false
    end
   else
    gg.toast("未搜到数据！")
    return false
  end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function Main()
menu = gg.choice({
  "🔥稳定区💥",--1
  "🔥不稳区💥",--2
  "🔥自调区💥",--3
  "🔥青铜区💥",--4
  "🔥美化区💥",--5
  "🔥防封区💥",--6
  "🔥牛逼区💥",--7
  "🔥点击复制我QQ，@我，我可以陪你玩，有问题也可以问我💥",--8
  "🌩离开穆深（不可以）😭",--9
}, nil, os.date("欢迎使用穆深脚本，防闪自己配"))
if menu == 1 then A() end
if menu == 2 then B() end
if menu == 3 then C() end
if menu == 4 then D() end
if menu == 5 then E() end
if menu == 6 then F() end
if menu == 7 then I() end
if menu == 8 then H() end
if menu == 9 then Exit() end
XGCK=-1
end



function A()
menu1 = gg.multiChoice({
"🐔完美开锁🐔",--1
"🐔3倍开锁🐔",--2
"🐔3.8倍移速🐔",--3
"🐔人物高跳🐔",--4
"🐔明亮透视🐔",--5
"🐔人物范围🐔",--6
"🐔开门加速🐔",--7
"🐔全图救人（较慢）🐔",--8
"🐔4v1全图开锁（较慢）🐔",--9
"🐔开启延迟🐔",--10
"🐔关闭延迟🐔",--11
"🐔穆深稳定上黄金一套（自动开启123458）🐔",--12
"🐒返回主页🐒",--13
}, nil, os.date("稳定黄金区（不要太猛，不然有意外）🐤"))
if menu1 == nil then else
if menu1[1] == true then a1() end
if menu1[2] == true then a2() end
if menu1[3] == true then a3() end
if menu1[4] == true then a4() end
if menu1[5] == true then a5() end
if menu1[6] == true then a6() end
if menu1[7] == true then a7() end
if menu1[8] == true then a8() end
if menu1[9] == true then a9() end
if menu1[10] == true then a10() end
if menu1[11] == true then a11() end
if menu1[12] == true then a12() end
if menu1[13] == true then HOME() end
end
GLWW=-1
end



function B()
menu1 = gg.multiChoice({
"🐣锁血🐥",
"🐣锁金🐥",
"🐣锁金关闭🐥",
"🐣拳套定人🐥",
"🐣返回主页🐥",
}, nil, os.date("顶多坚持两局（除了锁血，但是锁血结算时闪退）"))
if menu1 == nil then else
if menu1[1] == true then b1() end
if menu1[2] == true then b2() end
if menu1[3] == true then b3() end
if menu1[4] == true then b4() end
if menu1[5] == true then HOME() end
end
GLWW=-1
end



function C()
menu1 = gg.multiChoice({
"🐸开锁自调🐸",
"🐸移速自调🐸",
"🐸高跳自调🐸",
"🐸疾跑跳高时间自调🐸",
"🐸视野范围自调🐸",
"🐸医疗箱范围自调🐸",
"🐸手榴弹范围自调🐸",
"🐸手榴弹伤害自调🐸",
"🐸血量自调🐸",
"🐸开箱速度自调🐸",
"🐸部分武器连发自调🐸",
"️🐸返回主页🐸️",
}, nil, os.date("跳高，移速和开锁建议不要改，用稳定区的就行了🐰"))
if menu1 == nil then else
if menu1[1] == true then op1() end
if menu1[2] == true then op2() end
if menu1[3] == true then op3() end
if menu1[4] == true then op4() end
if menu1[5] == true then op5() end
if menu1[6] == true then op6() end
if menu1[7] == true then op7() end
if menu1[8] == true then op8() end
if menu1[9] == true then op9() end
if menu1[10] == true then op10() end
if menu1[11] == true then op11() end
if menu1[12] == true then HOME() end
end
GLWW=-1
end



function D()
menu1 = gg.multiChoice({
"🦁4v1激活逃生门🦁",
"🦁秒开一切（无法关闭）🦁",
"🦁10倍移速🦁",
"🦁锁血（结算闪退）🦁",
"🦁手雷全屏秒杀🦁",
"🦁️返回主页🦁",
}, nil, os.date("注:只能在青铜局开（封号不怪我）🐬🐬🐬"))
if menu1 == nil then else
if menu1[1] == true then i1() end
if menu1[2] == true then i2() end
if menu1[3] == true then i3() end
if menu1[4] == true then i4() end
if menu1[5] == true then i5() end
if menu1[6] == true then HOME() end
end
GLWW=-1
end



function E()
menu1 = gg.multiChoice({
"🙏治疗球集卡活动皮肤🙏",
"🙏飞爪氪金皮肤🙏",
"🙏小灰机赛季宝藏皮肤🙏",
"🙏生命护盾氪金皮肤🙏",
"🙏皮卡赛季宝藏皮肤🙏",
"🙏火箭筒集卡活动皮肤🙏",
"🙏火箭筒集卡活动皮肤2🙏",
"🙏火箭筒集卡活动皮肤3🙏",
"🙏冲锋枪签到活动皮肤🙏",
"🙏冲锋枪签到活动皮肤2🙏",
"🙏冲锋枪签到活动皮肤3🙏",
"🙏蹦蹦枪氪金皮肤🙏",
"🙏蹦蹦枪氪金皮肤2🙏",
"🙏蹦蹦枪氪金皮肤3🙏",
"🙏迫击炮赛季宝藏皮肤🙏",
"🙏迫击炮赛季宝藏皮肤2🙏",
"🙏迫击炮赛季宝藏皮肤3🙏",
"🙏肾上腺素赛季宝藏皮肤🙏",
"🙏滑板新年皮肤🙏",
"🙏生命护盾新年皮肤🙏",
"🙏肾上腺素汤圆皮肤🙏",
"🙏飞爪鲨鱼皮肤🙏",
"🙏能量腕炮4级皮肤🙏",
"🙏能量腕炮4级皮肤2🙏",
"🙏能量腕炮4级皮肤3🙏",
"🙏能量腕炮7级皮肤🙏",
"🙏能量腕炮7级皮肤2🙏",
"🙏能量腕炮7级皮肤3🙏",
"🙏跳跳杆4级皮肤🙏",
"🙏弹簧拳套4级皮肤🙏",
"🙏小灰机赛季宝藏皮肤[风格]🙏",
"🙏皮卡赛季宝藏皮肤[风格]🙏",
"🙏肾上腺素赛季宝藏皮肤[风格]🙏",
"🙏迫击炮赛季宝藏皮肤[风格]🙏",
"🙏迫击炮赛季宝藏皮肤[风格]2🙏",
"🙏迫击炮赛季宝藏皮肤[风格]3🙏",
"🙏能量腕炮7级皮肤[风格]🙏",
"🙏能量腕炮7级皮肤[风格]2🙏",
"🙏能量腕炮7级皮肤[风格]3🙏",
"️👍返回主页👍",
}, nil, os.date("跑路子墨的免费美化"))
if menu1 == nil then else
if menu1[1] == true then h1() end
if menu1[2] == true then h2() end
if menu1[3] == true then h3() end
if menu1[4] == true then h4() end
if menu1[5] == true then h5() end
if menu1[6] == true then h6() end
if menu1[7] == true then h7() end
if menu1[8] == true then h8() end
if menu1[9] == true then h9() end
if menu1[10] == true then h10() end
if menu1[11] == true then h11() end
if menu1[12] == true then h12() end
if menu1[13] == true then h13() end
if menu1[14] == true then h14() end
if menu1[15] == true then h15() end
if menu1[16] == true then h16() end
if menu1[17] == true then h17() end
if menu1[18] == true then h18() end
if menu1[19] == true then h19() end
if menu1[20] == true then h20() end
if menu1[21] == true then h21() end
if menu1[22] == true then h22() end
if menu1[23] == true then h23() end
if menu1[24] == true then h24() end
if menu1[25] == true then h25() end
if menu1[26] == true then h26() end
if menu1[27] == true then h27() end
if menu1[28] == true then h28() end
if menu1[29] == true then h29() end
if menu1[30] == true then h30() end
if menu1[31] == true then h31() end
if menu1[32] == true then h32() end
if menu1[33] == true then h33() end
if menu1[34] == true then h34() end
if menu1[35] == true then h35() end
if menu1[36] == true then h36() end
if menu1[37] == true then h37() end
if menu1[38] == true then h38() end
if menu1[39] == true then h39() end
if menu1[40] == true then HOME() end
end
GLWW=-1
end



function F()
menu1 = gg.multiChoice({
"🌪防举报🌪",
"🌪落尘防封（较慢且闪退）🌪",
"🌪下阳和贤哥防封（自己看着开）🌪",
"️🌪返回主页🌪",
}, nil, os.date("防封区（注:太猛照样封）💫💫💫"))
if menu1 == nil then else
if menu1[1] == true then f1() end
if menu1[2] == true then f2() end
if menu1[3] == true then f3() end
if menu1[4] == true then HOME() end
end
GLWW=-1
end


function I()
menu1 = gg.multiChoice({
"🌫实体金币🌫",--1
"🌫实体金币[关闭]🌫",--2
"🌫4v1吸人🌫",--3
"🌫8v2吸人🌫",--4
"🌫8v2秒赢🌫",--5
"🌫4v1秒赢🌫",--6
"🌫1秒开补给箱夹子🌫",--7
"🌫震荡波定人🌫",--8
"🌫震荡波小范围🌫",--9
"🌫震荡波大范围🌫",--10
"🌫震荡波定人[关闭]🌫",--11
"🌫跳跳杆远跳🌫",--12
"🌫跳跳杆最大远跳🌫",--13
"🌫跳跳杆秒落地🌫",--14
"🌫跳跳杆远跳反弹🌫",--15
"🌫跳跳杆跳高🌫",--16
"🌫弹簧拳套无后坐力🌫",--17
"🌫弹簧拳套拉长🌫",--18
"🌫弹簧拳套增大击退距离🌫",--19
"🌫弹簧拳套最大击退距离🌫",--20
"🌫弹簧拳套定人🌫",--21
"️⛄返回主页⛄",--22
}, nil, os.date("我牛不牛逼😏\n      卧槽，牛逼👍"))
if menu1 == nil then else
if menu1[1] == true then c1() end
if menu1[2] == true then c2() end
if menu1[3] == true then c3() end
if menu1[4] == true then c4() end
if menu1[5] == true then c5() end
if menu1[6] == true then c6() end
if menu1[7] == true then c7() end
if menu1[8] == true then c8() end
if menu1[9] == true then c9() end
if menu1[10] == true then c10() end
if menu1[11] == true then c11() end
if menu1[12] == true then c12() end
if menu1[13] == true then c13() end
if menu1[14] == true then c14() end
if menu1[15] == true then c15() end
if menu1[16] == true then c16() end
if menu1[17] == true then c17() end
if menu1[18] == true then c18() end
if menu1[19] == true then c19() end
if menu1[20] == true then c20() end
if menu1[21] == true then c21() end
if menu1[22] == true then HOME() end
end
GLWW=-1
end


function H()
menu1 = gg.multiChoice({
"✈复制穆深QQ号✈",
"🛫返回主页🛬️",
}, nil, os.date("穆深Q群\n760168956"))
if menu1 == nil then else
if menu1[1] == true then n1() end
if menu1[2] == true then HOME() end
end
GLWW=-1
end


function c1()--医疗箱微范围
qmnb = {
{["memory"] = 32},
{["name"] = "医疗箱微范围"},
{["value"] = 1.20000004768, ["type"] = 16},
{["lv"] = 3.0,["offset"] =4, ["type"] = 16},
{["lv"] = 200.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 1.5,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c2()--疾跑微加速
qmnb = {
{["memory"] = 32},
{["name"] = "疾跑微加速"},
{["value"] = 0.20000000298, ["type"] = 16},
{["lv"] = 6.0,["offset"] =-4, ["type"] = 16},
}
qmxg = {
{["value"] = 0.5,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c3()--手榴弹微范围
qmnb = {
{["memory"] = 32},
{["name"] = "手榴弹微范围"},
{["value"] = 2.0, ["type"] = 16},
{["lv"] = 2.5,["offset"] =4, ["type"] = 16},
{["lv"] = 1000.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 2.3,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c4()--增大手榴弹伤害
qmnb = {
{["memory"] = 32},
{["name"] = "增大手榴弹伤害"},
{["value"] = 33.0, ["type"] = 16},
{["lv"] = 105,["offset"] =8, ["type"] = 4},
{["lv"] = 103,["offset"] =16, ["type"] = 4},
}
qmxg = {
{["value"] = 50,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c5()--踩夹子微加速
qmnb = {
{["memory"] = 32},
{["name"] = "踩夹子微加速"},
{["value"] = -0.75, ["type"] = 16},
{["lv"] = 6.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 1,["offset"] =16, ["type"] = 4},
}
qmxg = {
{["value"] = 0.5,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c6()--踩夹子不减速
qmnb = {
{["memory"] = 32},
{["name"] = "踩夹子不减速"},
{["value"] = -0.75, ["type"] = 16},
{["lv"] = 6.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 1,["offset"] =16, ["type"] = 4},
}
qmxg = {
{["value"] = 0,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c7()--实体金币[大]
gg.alert("✨温馨提示✨\n开启后,开补给箱和夹子就可以获得大量的金币了,记得关闭,不然封号,会玩的自然稳定","★确定★")
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("0.6875", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("5", FLOAT)
gg.toast("实体金币[大]开启成功")
gg.clearResults()
end
end



function c8()--实体金币[大][关闭]
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("5", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("0.6875", FLOAT)
gg.toast("实体金币[大]关闭成功")
gg.clearResults()
end
end



function c9()--开启延迟
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("1000", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("666", FLOAT)
gg.toast("延迟开启成功")
gg.clearResults()
end
end



function c10()--关闭延迟
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("666", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("1000", FLOAT)
gg.toast("延迟关闭成功")
gg.clearResults()
end
end



function c11()--4v1吸人
qmnb = {
{["memory"] = 32},
{["name"] = "4v1吸人"},
{["value"] = 80, ["type"] = 4},
{["lv"] = 1.0,["offset"] =8, ["type"] = 16},
{["lv"] = 30,["offset"] =4, ["type"] = 4},
}
qmxg = {
{["value"] = 0,["offset"] =8, ["type"] = 16},
}
xqmnb(qmnb)
end



function c12()--8v2吸人
qmnb = {
{["memory"] = 32},
{["name"] = "8v2吸人"},
{["value"] = 39, ["type"] = 4},
{["lv"] = 1.0,["offset"] =4, ["type"] = 16},
{["lv"] = 88,["offset"] =-4, ["type"] = 4},
}
qmxg = {
{["value"] = 0,["offset"] =4, ["type"] = 16},
}
xqmnb(qmnb)
end



function c13()--锁金币无冷却
qmnb = {
{["memory"] = 32},
{["name"] = "锁金币无冷却"},
{["value"] = 89, ["type"] = 4},
{["lv"] = 100,["offset"] =4, ["type"] = 4},
{["lv"] = 102,["offset"] =36, ["type"] = 4},
}
qmxg = {
{["value"] = 0,["offset"] =36, ["type"] = 4},
}
xqmnb(qmnb)
end



function c14()--关闭锁金币无冷却
qmnb = {
{["memory"] = 32},
{["name"] = "关闭锁金币无冷却"},
{["value"] = 89, ["type"] = 4},
{["lv"] = 100,["offset"] =4, ["type"] = 4},
{["lv"] = 0,["offset"] =36, ["type"] = 4},
}
qmxg = {
{["value"] = 102,["offset"] =36, ["type"] = 4},
}
xqmnb(qmnb)
end



function c15()--开局小量金币
qmnb = {
{["memory"] = 32},
{["name"] = "开局小量金币"},
{["value"] = 3840, ["type"] = 4},
{["lv"] = 100,["offset"] =88, ["type"] = 4},
}
qmxg = {
{["value"] = 1500,["offset"] =88, ["type"] = 4},
}
xqmnb(qmnb)
end



function c16()--开局大量金币
qmnb = {
{["memory"] = 32},
{["name"] = "开局大量金币"},
{["value"] = 3840, ["type"] = 4},
{["lv"] = 100,["offset"] =88, ["type"] = 4},
}
qmxg = {
{["value"] = 99999,["offset"] =88, ["type"] = 4},
}
xqmnb(qmnb)
end



function c17()--8v2秒赢
gg.timeJump("17:50")
end



function c18()--4v1秒赢
gg.timeJump("14:50")
end



function c19()--开门加速
qmnb = {
{["memory"] = 32},
{["name"] = "开门加速"},
{["value"] = 8.0, ["type"] = 16},
{["lv"] = 1.0,["offset"] =16, ["type"] = 16},
}
qmxg = {
{["value"] = 6,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c20()--增加血量
qmnb = {
{["memory"] = 32},
{["name"] = "增加血量"},
{["value"] = 200.0, ["type"] = 16},
{["lv"] = 100.0,["offset"] =-20, ["type"] = 16},
{["lv"] = 100.0,["offset"] =-24, ["type"] = 16},
}
qmxg = {
{["value"] = 1200,["offset"] =-20, ["type"] = 16},
{["value"] = 1200,["offset"] =-24, ["type"] = 16},
}
xqmnb(qmnb)
end



function c21()--1秒开补给箱夹子
qmnb = {
{["memory"] = 32},
{["name"] = "1秒开补给箱夹子"},
{["value"] = 0.20000000298, ["type"] = 16},
{["lv"] = 5.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 1.0,["offset"] =8, ["type"] = 16},
}
qmxg = {
{["value"] = 1,["offset"] =-4, ["type"] = 16},
}
xqmnb(qmnb)
end



function c22()--部分武器100连发
qmnb = {
{["memory"] = 32},
{["name"] = "部分武器100连发"},
{["value"] = 1.100000023841858, ["type"] = 16},
{["lv"] = 1, ["offset"] = -4, ["type"] = 4},
}
qmxg = {
{["value"] = 100, ["offset"] = -4, ["type"] = 4},
}
xqmnb(qmnb)
end



function c23()--部分武器100连发[关闭]
qmnb = {
{["memory"] = 32},
{["name"] = "部分武器100连发[关闭]"},
{["value"] = 1.100000023841858, ["type"] = 16},
{["lv"] = 100, ["offset"] = -4, ["type"] = 4},
}
qmxg = {
{["value"] = 1, ["offset"] = -4, ["type"] = 4},
}
xqmnb(qmnb)
end



function c24()--显示夹子范围
qmnb = {
{["memory"] = 32},
{["name"] = "显示夹子范围"},
{["value"] = 25.0, ["type"] = 16},
{["lv"] = 1.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 0.5,["offset"] =-8, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-12, ["type"] = 16},
}
qmxg = {
{["value"] = 100,["offset"] =-12, ["type"] = 16},
}
xqmnb(qmnb)
end



function c25()--全图禁闭室
qmnb = {
{["memory"] = 32},
{["name"] = "全图禁闭室"},
{["value"] = 100.0, ["type"] = 16},
{["lv"] = 0.30000001192092896, ["offset"] = 4, ["type"] = 16},
}
qmxg = {
{["value"] = 9999, ["offset"] = 4, ["type"] = 16},
}
xqmnb(qmnb)
end



function c26()--震荡波定人
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波定人"},
{["value"] = 4.0, ["type"] = 16},
{["lv"] = 0.30000001192092896, ["offset"] = 4, ["type"] = 16},
}
qmxg = {
{["value"] = 9999, ["offset"] = 4, ["type"] = 16},
}
xqmnb(qmnb)
end



function c27()--震荡波释放范围
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波释放范围"},
{["value"] = 7.0, ["type"] = 16},
{["lv"] = 7.0,["offset"] =4, ["type"] = 16},
}
qmxg = {
{["value"] = 10,["offset"] =4, ["type"] = 16},
}
xqmnb(qmnb)
end



function c28()--震荡波小范围
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波小范围"},
{["value"] = 0.20000000298, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-4, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 3,["offset"] =0, ["type"] = 16},
{["value"] = 3,["offset"] =-8, ["type"] = 16},
}
xqmnb(qmnb)
end



function c29()--震荡波大范围
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波大范围"},
{["value"] = 0.20000000298, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-4, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 6,["offset"] =0, ["type"] = 16},
{["value"] = 6,["offset"] =-8, ["type"] = 16},
}
xqmnb(qmnb)
end



function c30()--震荡波瞬移
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波瞬移"},
{["value"] = 4.0, ["type"] = 16},
{["lv"] = 0.30000001192092896,["offset"] =4, ["type"] = 16},
}
qmxg = {
{["value"] = 9999,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c31()--震荡波全屏范围
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波全屏范围"},
{["value"] = 0.20000000298, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-4, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 9999,["offset"] =0, ["type"] = 16},
{["value"] = 9999,["offset"] =-8, ["type"] = 16},
}
xqmnb(qmnb)
end



function c32()--震荡波定人[关闭]
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波定人[关闭]"},
{["value"] = 9999, ["type"] = 16},
{["lv"] = 4.0, ["offset"] = -4, ["type"] = 16},
}
qmxg = {
{["value"] = 0.30000001192092896, ["offset"] = 0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c33()--震荡波瞬移[关闭]
qmnb = {
{["memory"] = 32},
{["name"] = "震荡波瞬移[关闭]"},
{["value"] = 9999, ["type"] = 16},
{["lv"] = 0.30000001192092896,["offset"] =4, ["type"] = 16},
}
qmxg = {
{["value"] = 4.0,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c34()--弹簧拳套无冷却
qmnb = {
{["memory"] = 32},
{["name"] = "弹簧拳套无冷却"},
{["value"] = 8.0, ["type"] = 16},
{["lv"] = 13,["offset"] =8, ["type"] = 4},
}
qmxg = {
{["value"] = 0,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c35()--跳跳杆远跳
qmnb = {
{["memory"] = 32},
{["name"] = "跳跳杆远跳"},
{["value"] = 3.0, ["type"] = 16},
{["lv"] = 3.0,["offset"] =4, ["type"] = 16},
{["lv"] = 3.0,["offset"] =8, ["type"] = 16},
}
qmxg = {
{["value"] = 10,["offset"] =8, ["type"] = 16},
}
xqmnb(qmnb)
end



function c36()--跳跳杆最大远跳
qmnb = {
{["memory"] = 32},
{["name"] = "跳跳杆最大远跳"},
{["value"] = 3.0, ["type"] = 16},
{["lv"] = 3.0,["offset"] =4, ["type"] = 16},
{["lv"] = 3.0,["offset"] =8, ["type"] = 16},
}
qmxg = {
{["value"] = 99,["offset"] =8, ["type"] = 16},
}
xqmnb(qmnb)
end



function c37()--跳跳杆秒落地
qmnb = {
{["memory"] = 32},
{["name"] = "跳跳杆秒落地"},
{["value"] = 1025, ["type"] = 4},
{["lv"] = 0.5,["offset"] =-36, ["type"] = 16},
}
qmxg = {
{["value"] = 0,["offset"] =-36, ["type"] = 16},
}
xqmnb(qmnb)
end



function c38()--跳跳杆远跳反弹
qmnb = {
{["memory"] = 32},
{["name"] = "跳跳杆远跳反弹"},
{["value"] = 1025, ["type"] = 4},
{["lv"] = 0.75,["offset"] =-32, ["type"] = 16},
}
qmxg = {
{["value"] = 99,["offset"] =-32, ["type"] = 16},
}
xqmnb(qmnb)
end



function c39()--跳跳杆跳高
qmnb = {
{["memory"] = 32},
{["name"] = "跳跳杆跳高"},
{["value"] = 2.79999995232, ["type"] = 16},
{["lv"] = 1025,["offset"] =28, ["type"] = 4},
}
qmxg = {
{["value"] = 10,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c40()--弹簧拳套无后坐力
qmnb = {
{["memory"] = 32},
{["name"] = "弹簧拳套无后坐力"},
{["value"] = 3.0, ["type"] = 16},
{["lv"] = 0.5,["offset"] =-4, ["type"] = 16},
}
qmxg = {
{["value"] = 0,["offset"] =-4, ["type"] = 16},
}
xqmnb(qmnb)
end



function c41()--弹簧拳套拉长
qmnb = {
{["memory"] = 32},
{["name"] = "弹簧拳套拉长"},
{["value"] = 0.30000001192, ["type"] = 16},
{["lv"] = 1.0,["offset"] =4, ["type"] = 16},
}
qmxg = {
{["value"] = 9999,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function c42()--弹簧拳套增大击退距离
qmnb = {
{["memory"] = 32},
{["name"] = "弹簧拳套增大击退距离"},
{["value"] = 0.23000000417, ["type"] = 16},
{["lv"] = 4.5,["offset"] =-32, ["type"] = 16},
}
qmxg = {
{["value"] = 10,["offset"] =-32, ["type"] = 16},
}
xqmnb(qmnb)
end



function c43()--弹簧拳套最大击退距离
qmnb = {
{["memory"] = 32},
{["name"] = "弹簧拳套增大击退距离"},
{["value"] = 0.23000000417, ["type"] = 16},
{["lv"] = 4.5,["offset"] =-32, ["type"] = 16},
}
qmxg = {
{["value"] = 999,["offset"] =-32, ["type"] = 16},
}
xqmnb(qmnb)
end



function c44()--弹簧拳套定人
qmnb = {
{["memory"] = 32},
{["name"] = "弹簧拳套定人"},
{["value"] = 0.23000000417, ["type"] = 16},
{["lv"] = 4.5,["offset"] =-28, ["type"] = 16},
}
qmxg = {
{["value"] = 0,["offset"] =-28, ["type"] = 16},
}
xqmnb(qmnb)
end




function a1()--完美开锁
qmnb = {
{["memory"] = 32},
{["name"] = "完美开锁"},
{["value"] = 59.0, ["type"] = 16},
{["lv"] = 16.0, ["offset"] = 4, ["type"] = 16},
}
qmxg = {
{["value"] = 99999, ["offset"] = 4, ["type"] = 16},
}
xqmnb(qmnb)
end




function a2()--3倍开锁
qmnb = {
{["memory"] = 32},
{["name"] = "3倍开锁"},
{["value"] = 1.5, ["type"] = 16},
{["lv"] = 1.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 2.0,["offset"] =4, ["type"] = 16},
{["lv"] = 2.5,["offset"] =8, ["type"] = 16},
}
qmxg = {
{["value"] = 3,["offset"] =-4, ["type"] = 16},
}
xqmnb(qmnb)
end



function a3()--3.8倍移速
qmnb = {
{["memory"] = 32},
{["name"] = "3.8倍移速"},
{["value"] = 2.79999995232, ["type"] = 16},
{["lv"] = 20.0,["offset"] =4, ["type"] = 16},
{["lv"] = 900.0,["offset"] =12, ["type"] = 16},
}
qmxg = {
{["value"] = 3.8,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)


end



function a4()--高跳
qmnb = {
{["memory"] = 32},
{["name"] = "人物高跳"},
{["value"] = 4.900000095367432, ["type"] = 16},
{["lv"] = 900.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 20.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 7,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function a5()--明透
qmnb = {
{["memory"] = 32},
{["name"] = "明亮透视"},
{["value"] = 2.5, ["type"] = 16},
{["lv"] = 1.0,["offset"] =4, ["type"] = 16},
{["lv"] = 8.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 12.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = 100,["offset"] =-4, ["type"] = 16},
}
xqmnb(qmnb)
end



function a6()--范围锁门人
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("1.29999995232", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("5", FLOAT)
gg.toast("人物范围开启成功")
gg.clearResults()
end
end


function a7()--开门加速
qmnb = {
{["memory"] = 32},
{["name"] = "开门加速"},
{["value"] = 8.0, ["type"] = 16},
{["lv"] = 1.0,["offset"] =16, ["type"] = 16},
}
qmxg = {
{["value"] = 6,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function a8()
	 gg.clearResults()
	 gg.setRanges(32)
	 gg.searchNumber("0.75;0.2;1.3;1.3;1D;100D::", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("1.3", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(100)
	 gg.editAll("260", gg.TYPE_FLOAT)
	 gg.toast("全图救人开启成功")
	 gg.clearResults()
end



function a9()
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("30;0.2;1.3;1.3;1::50", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
gg.searchNumber("1.3", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(100)
gg.editAll("1000", gg.TYPE_FLOAT)
gg.toast("全屏开锁（4V1有效）")
gg.clearResults()
end



function a10()--开启延迟
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("1000", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("666", FLOAT)
gg.toast("延迟开启成功（对面看不到你的本体）")
gg.clearResults()
end
end



function a11()--关闭延迟
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("666", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("1000", FLOAT)
gg.toast("延迟关闭成功（可以看到你了）")
gg.clearResults()
end
end




function a12()
a1()
a2()
a3()
a4()
a5()
a8()
end


	 

function b1()--锁血
gg.alert("温馨提示\n（结算时会闪退）","确定")
qmnb = {
{["memory"] = 32},
{["name"] = "锁血"},
{["value"] = 1.5, ["type"] = 16},
{["lv"] = 2.0,["offset"] =-4, ["type"] = 16},
}
qmxg = {
{["value"] = 100,["offset"] =-4, ["type"] = 16},
{["value"] = -1,["offset"] =4, ["type"] = 4},
}
xqmnb(qmnb)
end




function b2()--锁金币无冷却
gg.alert("温馨提示\n秒封〔顶多坚持两局〕","确定")
qmnb = {
{["memory"] = 32},
{["name"] = "锁金币无冷却"},
{["value"] = 89, ["type"] = 4},
{["lv"] = 100,["offset"] =4, ["type"] = 4},
{["lv"] = 102,["offset"] =36, ["type"] = 4},
}
qmxg = {
{["value"] = 0,["offset"] =36, ["type"] = 4},
}
xqmnb(qmnb)
end






function b3()--关闭锁金币无冷却
qmnb = {
{["memory"] = 32},
{["name"] = "关闭锁金币无冷却"},
{["value"] = 89, ["type"] = 4},
{["lv"] = 100,["offset"] =4, ["type"] = 4},
{["lv"] = 0,["offset"] =36, ["type"] = 4},
}
qmxg = {
{["value"] = 102,["offset"] =36, ["type"] = 4},
}
xqmnb(qmnb)
end




function b4()--拳套定人
gg.alert("温馨提示\n秒封〔顶多坚持两局〕","确定")
qmnb = {
{["memory"] = 32},
{["name"] = "拳套定人"},
{["value"] = 0.23000000417, ["type"] = 16},
{["lv"] = 4.5,["offset"] =-28, ["type"] = 16},
}
qmxg = {
{["value"] = 0,["offset"] =-28, ["type"] = 16},
}
xqmnb(qmnb)
end



function h1()--治疗球集卡活动皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("501200", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601461", DWORD)
gg.toast("治疗球集卡活动皮肤美化成功")
gg.clearResults()
end
end



function h2()--飞爪氪金皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500500", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601466", DWORD)
gg.toast("飞爪氪金皮肤美化成功")
gg.clearResults()
end
end



function h3()--小灰机赛季宝藏皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("501700", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601471", DWORD)
gg.toast("小灰机赛季宝藏皮肤美化成功")
gg.clearResults()
end
end



function h4()--生命护盾氪金皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500007", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601476", DWORD)
gg.toast("生命护盾氪金皮肤美化成功")
gg.clearResults()
end
end



function h5()--皮卡赛季宝藏皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500002", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601486", DWORD)
gg.toast("皮卡赛季宝藏皮肤美化成功")
gg.clearResults()
end
end



function h6()--火箭筒集卡活动皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500010", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601491", DWORD)
gg.toast("火箭筒集卡活动皮肤美化成功")
gg.clearResults()
end
end



function h7()--火箭筒集卡活动皮肤2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500011", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601491", DWORD)
gg.toast("火箭筒集卡活动皮肤2美化成功")
gg.clearResults()
end
end



function h8()--火箭筒集卡活动皮肤3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500012", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601491", DWORD)
gg.toast("火箭筒集卡活动皮肤3美化成功")
gg.clearResults()
end
end



function h9()--冲锋枪签到活动皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500030", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601496", DWORD)
gg.toast("冲锋枪签到活动皮肤美化成功")
gg.clearResults()
end
end



function h10()--冲锋枪签到活动皮肤2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500031", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601496", DWORD)
gg.toast("冲锋枪签到活动皮肤2美化成功")
gg.clearResults()
end
end



function h11()--冲锋枪签到活动皮肤3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500032", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601496", DWORD)
gg.toast("冲锋枪签到活动皮肤3美化成功")
gg.clearResults()
end
end



function h12()--蹦蹦枪氪金皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500050", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601501", DWORD)
gg.toast("蹦蹦枪氪金皮肤美化成功")
gg.clearResults()
end
end



function h13()--蹦蹦枪氪金皮肤2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500051", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601501", DWORD)
gg.toast("蹦蹦枪氪金皮肤2美化成功")
gg.clearResults()
end
end



function h14()--蹦蹦枪氪金皮肤3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500052", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601501", DWORD)
gg.toast("蹦蹦枪氪金皮肤3美化成功")
gg.clearResults()
end
end



function h15()--迫击炮赛季宝藏皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500020", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601506", DWORD)
gg.toast("迫击炮赛季宝藏皮肤美化成功")
gg.clearResults()
end
end



function h16()--迫击炮赛季宝藏皮肤2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500021", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601506", DWORD)
gg.toast("迫击炮赛季宝藏皮肤2美化成功")
gg.clearResults()
end
end



function h17()--迫击炮赛季宝藏皮肤3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500022", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601506", DWORD)
gg.toast("迫击炮赛季宝藏皮肤3美化成功")
gg.clearResults()
end
end



function h18()--肾上腺素赛季宝藏皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500300", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601511", DWORD)
gg.toast("肾上腺素赛季宝藏皮肤美化成功")
gg.clearResults()
end
end



function h19()--滑板新年皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500900", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601521", DWORD)
gg.toast("滑板新年皮肤美化成功")
gg.clearResults()
end
end



function h20()--生命护盾新年皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500007", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601526", DWORD)
gg.toast("生命护盾新年皮肤美化成功")
gg.clearResults()
end
end



function h21()--肾上腺素汤圆皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500300", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601531", DWORD)
gg.toast("肾上腺素汤圆皮肤美化成功")
gg.clearResults()
end
end



function h22()--飞爪鲨鱼皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500500", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601551", DWORD)
gg.toast("飞爪鲨鱼皮肤美化成功")
gg.clearResults()
end
end



function h23()--能量腕炮4级皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500060", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601556", DWORD)
gg.toast("能量腕炮4级皮肤美化成功")
gg.clearResults()
end
end



function h24()--能量腕炮4级皮肤2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500061", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601556", DWORD)
gg.toast("能量腕炮4级皮肤2美化成功")
gg.clearResults()
end
end



function h25()--能量腕炮4级皮肤3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500062", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601556", DWORD)
gg.toast("能量腕炮4级皮肤3美化成功")
gg.clearResults()
end
end



function h26()--能量腕炮7级皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500060", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601561", DWORD)
gg.toast("能量腕炮7级皮肤美化成功")
gg.clearResults()
end
end



function h27()--能量腕炮7级皮肤2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500061", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601561", DWORD)
gg.toast("能量腕炮7级皮肤2美化成功")
gg.clearResults()
end
end



function h28()--能量腕炮7级皮肤3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500062", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601561", DWORD)
gg.toast("能量腕炮7级皮肤3美化成功")
gg.clearResults()
end
end



function h29()--跳跳杆4级皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("501900", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601566", DWORD)
gg.toast("跳跳杆4级皮肤美化成功")
gg.clearResults()
end
end



function h30()--弹簧拳套4级皮肤
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("502000", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("601571", DWORD)
gg.toast("弹簧拳套4级皮肤美化成功")
gg.clearResults()
end
end



function h31()--小灰机赛季宝藏皮肤[风格]
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("501700", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650571", DWORD)
gg.toast("小灰机赛季宝藏皮肤[风格]美化成功")
gg.clearResults()
end
end



function h32()--皮卡赛季宝藏皮肤[风格]
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500002", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650581", DWORD)
gg.toast("皮卡赛季宝藏皮肤[风格]美化成功")
gg.clearResults()
end
end



function h33()--肾上腺素赛季宝藏皮肤[风格]
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500300", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650591", DWORD)
gg.toast("肾上腺素赛季宝藏皮肤[风格]美化成功")
gg.clearResults()
end
end



function h34()--迫击炮赛季宝藏皮肤[风格]
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500020", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650601", DWORD)
gg.toast("迫击炮赛季宝藏皮肤[风格]美化成功")
gg.clearResults()
end
end



function h35()--迫击炮赛季宝藏皮肤[风格]2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500021", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650601", DWORD)
gg.toast("迫击炮赛季宝藏皮肤[风格]2美化成功")
gg.clearResults()
end
end



function h36()--迫击炮赛季宝藏皮肤[风格]3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500022", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650601", DWORD)
gg.toast("迫击炮赛季宝藏皮肤[风格]3美化成功")
gg.clearResults()
end
end



function h37()--能量腕炮7级皮肤[风格]
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500060", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650611", DWORD)
gg.toast("能量腕炮7级皮肤[风格]美化成功")
gg.clearResults()
end
end



function h38()--能量腕炮7级皮肤[风格]2
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500061", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650611", DWORD)
gg.toast("能量腕炮7级皮肤[风格]2美化成功")
gg.clearResults()
end
end



function h39()--能量腕炮7级皮肤[风格]3
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("500062", DWORD, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",DWORD , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("650611", DWORD)
gg.toast("能量腕炮7级皮肤[风格]3美化成功")
gg.clearResults()
end
end



function i1()--4v1激活逃生门[逃生]
qmnb = {
{["memory"] = 32},
{["name"] = "4v1激活逃生门"},
{["value"] = 30.0, ["type"] = 16},
{["lv"] = 0.20000000298023224, ["offset"] = 4, ["type"] = 16},
}
qmxg = {
{["value"] = 0, ["offset"] = 0, ["type"] = 16},
}
xqmnb(qmnb)
end



function i2()--秒开一切[逃生]
gg.clearResults()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("0.6875", FLOAT, false, gg.SIGN_EQUAL, 0, -1)
if gg.getResultCount() == 0 then
gg.toast("开启失败")
else
gg.searchNumber("",FLOAT , false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(200)--设置修改前200个代码
gg.editAll("5", FLOAT)
gg.toast("秒开一切开启成功（关不掉）")
gg.clearResults()
end
end



function i3()--10倍移速[逃生]
qmnb = {
{["memory"] = 32},
{["name"] = "10倍移速（起飞）"},
{["value"] = 2.79999995232, ["type"] = 16},
{["lv"] = 20.0,["offset"] =4, ["type"] = 16},
{["lv"] = 900.0,["offset"] =12, ["type"] = 16},
}
qmxg = {
{["value"] = 10,["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function i4()--锁血[逃生]
qmnb = {
{["memory"] = 32},
{["name"] = "锁血（结算时闪退）"},
{["value"] = 1.5, ["type"] = 16},
{["lv"] = 2.0,["offset"] =-4, ["type"] = 16},
}
qmxg = {
{["value"] = 100,["offset"] =-4, ["type"] = 16},
{["value"] = -1,["offset"] =4, ["type"] = 4},
}
xqmnb(qmnb)
end



function i5()--手雷全屏秒杀[追捕]
qmnb = {
{["memory"] = 32},
{["name"] = "手雷全屏秒杀"},
{["value"] = 33.0, ["type"] = 16},
{["lv"] = 2.0,["offset"] =-124, ["type"] = 16},
{["lv"] = 2.5,["offset"] =-120, ["type"] = 16},
}
qmxg = {
{["value"] = 9999,["offset"] =0, ["type"] = 16},
{["value"] = 9999,["offset"] =-124, ["type"] = 16},
}
xqmnb(qmnb)
end



function op1()--开锁[自调]
local fy=gg.prompt({"开锁[自调]"}, {[1] = 3}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "开锁"},
{["value"] = 1.5, ["type"] = 16},
{["lv"] = 1.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 2.0,["offset"] =4, ["type"] = 16},
{["lv"] = 2.5,["offset"] =8, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =-4, ["type"] = 16},
}
xqmnb(qmnb)
end



function op2()--移速[自调]
local fy=gg.prompt({"移速[自调]"}, {[1] = 3.8}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "移速"},
{["value"] = 2.79999995232, ["type"] = 16},
{["lv"] = 20.0,["offset"] =4, ["type"] = 16},
{["lv"] = 900.0,["offset"] =12, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function op3()--高跳[自调]
local fy=gg.prompt({"高跳[自调]"}, {[1] = 6.8}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "高跳"},
{["value"] = 4.900000095367432, ["type"] = 16},
{["lv"] = 900.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 20.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function op4()
local es=gg.prompt({"请输入修改值\n建议10左右"}, {[1] = 10}, {[1] = "text"})
 if es==nil then 
ES=gg.alert("你不要我了吗？😭","是的","手滑") end
if ES==1 then os.exit(print("嘤嘤嘤"))end
if ES==2 then 
qmnb = {
{["memory"] = 32},
{["name"] = "疾跑跳高时间"},
{["value"] = 4800, ["type"] = 4},
{["lv"] = 1.8216880036222622e-44,["offset"] =-0x1C, ["type"] = 16},
}
qmxg = {
{["value"] = 10,["offset"] =-0x24, ["type"] = 16},
}
xqmnb(qmnb)
gg.alert("您的疾跑跳高基础时间成功更改为10s") 
Main1()
os.exit(print("嗨害嗨"))
end
qmnb = {
{["memory"] = 32},
{["name"] = "疾跑跳高时间"},
{["value"] = 4800, ["type"] = 4},
{["lv"] = 1.8216880036222622e-44,["offset"] =-0x1C, ["type"] = 16},
--{["lv"] = 4.300000190734863,["offset"] =-0x24, ["type"] = 16},
}
qmxg = {
{["value"] = es[1],["offset"] =-0x24, ["type"] = 16},
}
xqmnb(qmnb)
gg.alert("您的疾跑跳高基础时间更改为"..es[1].."s\n             有bag")
end



function op5()--视野范围[自调]
local fy=gg.prompt({"视野范围[自调]"}, {[1] = 15}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "视野范围"},
{["value"] = 12.0, ["type"] = 16},
{["lv"] = 10.0,["offset"] =-0x14, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end





function op6()--医疗箱范围[自调]
local fy=gg.prompt({"医疗箱范围[自调]"}, {[1] = 1.5}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "医疗箱范围"},
{["value"] = 1.20000004768, ["type"] = 16},
{["lv"] = 3.0,["offset"] =4, ["type"] = 16},
{["lv"] = 200.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function op7()--手榴弹范围[自调]
local fy=gg.prompt({"手榴弹范围[自调]"}, {[1] = 2.3}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "手榴弹范围"},
{["value"] = 2.0, ["type"] = 16},
{["lv"] = 2.5,["offset"] =4, ["type"] = 16},
{["lv"] = 1000.0,["offset"] =-8, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function op8()--手榴弹伤害[自调]
local fy=gg.prompt({"手榴弹伤害[自调]"}, {[1] = 50}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "手榴弹伤害"},
{["value"] = 33.0, ["type"] = 16},
{["lv"] = 105,["offset"] =8, ["type"] = 4},
{["lv"] = 103,["offset"] =16, ["type"] = 4},
}
qmxg = {
{["value"] = fy[1],["offset"] =0, ["type"] = 16},
}
xqmnb(qmnb)
end



function op9()--自身血量[自调]
local fy=gg.prompt({"自身血量[自调]"}, {[1] = 1200}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "自身血量"},
{["value"] = 200.0, ["type"] = 16},
{["lv"] = 100.0,["offset"] =-20, ["type"] = 16},
{["lv"] = 100.0,["offset"] =-24, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =-20, ["type"] = 16},
{["value"] = fy[1],["offset"] =-24, ["type"] = 16},
}
xqmnb(qmnb)
end



function op10()--开补给箱夹子速度[自调]
local fy=gg.prompt({"开补给箱夹子速度[自调]"}, {[1] = 1}, {[1] = "text"})
if fy==nil then os.exit(print("你点击了取消")) end
qmnb = {
{["memory"] = 32},
{["name"] = "开补给箱夹子速度"},
{["value"] = 0.20000000298, ["type"] = 16},
{["lv"] = 5.0,["offset"] =-4, ["type"] = 16},
{["lv"] = 1.0,["offset"] =8, ["type"] = 16},
}
qmxg = {
{["value"] = fy[1],["offset"] =-4, ["type"] = 16},
}
xqmnb(qmnb)
end



function op11()--部分武器连发[开启][自调]
local fy=gg.prompt({"部分武器连发[开启][自调]"}, {[1] = 100}, {[1] = "text"})
if fy==nil then os.exit(print("你点取消了")) end
qmnb = {
{["memory"] = 32},
{["name"] = "部分武器连发[开启]"},
{["value"] = 1.100000023841858, ["type"] = 16},
{["lv"] = 1, ["offset"] = -4, ["type"] = 4},
}
qmxg = {
{["value"] = fy[1], ["offset"] = -4, ["type"] = 4},
}
xqmnb(qmnb)
end



function f1()
	 gg.clearResults()
	 gg.setRanges(16384)
	 gg.searchNumber(":seconds", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber(":seconds", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(99999)
	 gg.editAll("防举报", gg.TYPE_BYTE)
	 gg.toast("防举报开启成功（太猛照样封）")
	 gg.clearResults()
end



function f2()
	 gg.clearResults()
	 gg.setRanges(32)
	 gg.searchNumber("2;3;5;1.5", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("3", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 jg=gg.getResults(100)
	 sl=gg.getResultCount()
	 if sl>100 then sl=100 end
	 for i = 1, sl do
	 	 dzy=jg[i].address
	 	 gg.addListItems({[1] = {address = dzy,flags = gg.TYPE_FLOAT,freeze = true,value = 3}})
	 end
	 gg.toast("穆深提示您，落尘防封开启成功")
	 gg.clearResults()
end



function f3()
menu1 = gg.multiChoice({
"🔴下阳防1🔴",
"🔴下阳防2🔴",
"🔴下阳防3🔴",
"🔴下阳防4🔴",
"🔴贤哥Xa防🔴",
"🔴贤哥Xa防2🔴",
"️🌪返回主页🌪",
}, nil, os.date("🔴下阳和贤哥逃跑防封🔴"))
if menu1 == nil then else
if menu1[1] == true then j1() end
if menu1[2] == true then j2() end
if menu1[3] == true then j3() end
if menu1[4] == true then j4() end
if menu1[5] == true then j5() end
if menu1[6] == true then j6() end
if menu1[7] == true then HOME() end
end
GLWW=-1
end

function j1()
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("10;0.2;1;1;1;1D::", gg.TYPE_FLOAT,false,gg.SIGN_EQUAL,0, -1)
gg.searchNumber("10", gg.TYPE_FLOAT,false,gg.SIGN_EQUAL,0,-1)
gg.getResults(100)
gg.editAll("0",gg.TYPE_FLOAT)
gg.toast("防封开启成功")
end


function j2()
gg.clearResults()--防封
gg.setRanges(4)
gg.searchNumber("17585", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.searchNumber("", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(1000)
gg.editAll("0", gg.TYPE_DWORD)
gg.clearResults()
gg.setRanges(4)
gg.searchNumber("11253", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.searchNumber("", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(1001)
gg.editAll("0", gg.TYPE_DWORD)	
gg.clearResults()
gg.setRanges(4)
gg.searchNumber("15992", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.searchNumber("", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(1001)
gg.editAll("0", gg.TYPE_DWORD)	
gg.clearResults()
gg.setRanges(4)
gg.searchNumber("16046", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.searchNumber("", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(1001)
gg.editAll("0", gg.TYPE_DWORD)	
gg.clearResults()
gg.setRanges(4)
gg.searchNumber("12906", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.searchNumber("", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
gg.getResults(1000)
gg.editAll("0", gg.TYPE_DWORD) 
gg.toast("防封开启成功")
gg.clearResults()
end



function j3()
	 gg.clearResults()
	 gg.setRanges(32)
	 gg.searchNumber("2.19902326e12", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(100)
	 gg.editAll("-1", gg.TYPE_FLOAT)
	 gg.toast("防封开启成功")
	 gg.clearResults()
end

function j4()
	 gg.clearResults()
	 gg.setRanges(4)
	 gg.searchNumber("-0.01533294842", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(100)
	 gg.editAll("-1", gg.TYPE_FLOAT)
	 gg.toast("防封开启成功")
	 gg.clearResults()
end


function j5()
	 gg.clearResults()
	 gg.setRanges(16384)
	 gg.searchNumber("1,885,692,792;1,852,795,252;1,752,459,118", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("1,885,692,792;1,852,795,252;1,752,459,118", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(100)
	 gg.editAll("0", gg.TYPE_DWORD)
	 gg.toast("贤哥防封开启成功")
	 gg.clearResults()
end



function j6()
	 gg.clearResults()
	 gg.setRanges(16384)
	 gg.searchNumber("1,885,692,792;1,852,795,252;1,752,459,118", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	 gg.searchNumber("1,885,692,792;1,852,795,252;1,752,459,118", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
	 gg.getResults(100)
	 gg.editAll("0", gg.TYPE_DWORD)
	 gg.toast("贤哥防封开启成功")
	 gg.clearResults()
end



function n1()
gg.copyText("\n760168953")
gg.alert("穆深QQ号已复制成功\n打开qq搜索QQ号即可")
end




function Exit()
print("可恶，怎么可以离开我\n😭😭😭")
os.exit()
end



function HOME()
lw=1
Main()
end



cs = ''
while(true)do
if gg.isVisible(true) then
XGCK=1
gg.setVisible(false)
end
gg.clearResults()
if XGCK==1 then
Main()
end
end




