module Mockup::SampleData
  GUAHAO_PATIENTS = [
    {name: '王大锤',   gender: '男', label: '普通'},
    {name: '张本煜',   gender: '男', label: '体检'},
    {name: '龚小爱',   gender: '女', label: '治疗'},
    {name: '孔连顺',   gender: '女', label: '体检'},
    {name: '张本煜',   gender: '男', label: '普通'},
    {name: '刘循子墨', gender: '男', label: '普通'},
    {name: '易小星',   gender: '男', label: '治疗'},
    {name: '夏一可',   gender: '女', label: '体检'},
    {name: '葛布',     gender: '女', label: '普通'},
    {name: '唐巍',     gender: '男', label: '体检'},
    {name: '孔晓婷',   gender: '女', label: '普通'},
    {name: '钱多多',   gender: '男', label: '体检'},
    {name: '许小桀',   gender: '男', label: '普通'},
    {name: '顾慎为',   gender: '男', label: '治疗'},
    {name: '韩颂',    gender: '男', label: '体检'},
    {name: '上官瑞',   gender: '女', label: '治疗'},
  ].map.with_index do |x, idx|
    x.merge({
      number: 301 + idx
    })
  end

  ZAIGUAN_PATIENTS = [
    {name: '方项',  gender: '男', label: '等待体检'},
    {name: '刘万才', gender: '男', label: '等待治疗'},
    {name: '叶澈雨', gender: '女', label: '等待复核'},
    {name: '杨奉', gender: '男', label: '等待初诊'},
    {name: '孟娥', gender: '女', label: '等待体检'},
    {name: '罗焕章', gender: '男', label: '等待体检'},
    {name: '佟乐乐', gender: '女', label: '等待治疗'},
    {name: '于小雪', gender: '女', label: '等待初诊'},
    {name: '白冰', gender: '女', label: '等待体检'},
    {name: '莫虹', gender: '女', label: '等待初诊'},
    {name: '李云龙', gender: '男', label: '等待初诊'},
    {name: '沐沁欣', gender: '女', label: '等待治疗'},
    {name: '陆婵娟', gender: '女', label: '等待复核'},
    {name: '李频', gender: '男', label: '等待治疗'},
    {name: '单冬青', gender: '男', label: '等待治疗'},
    {name: '穆文昌', gender: '男', label: '等待初诊'},
  ].map.with_index do |x, idx|
    x.merge({
      number: 533 + idx
    })
  end

  DOCTORS = [
    {name: '李海峰', busy: true, patient: '任庆春'},
    {name: '廖国林', busy: false},
    {name: '周小娟', busy: true, patient: '张瑞祥'},
    {name: '杨晓勇', busy: false},
    {name: '朱杰辉', busy: true, patient: '杨光'},
    {name: '叶建华', busy: false},
    {name: '游琼', busy: false},
    {name: '周丽琴', busy: false},
  ]

  PES = [
    {name: '谭新文', busy: false},
    {name: '刘雨晨', busy: true, patient: '张一楠'},
    {name: '钟诤', busy: false},
    {name: '王少峰', busy: false},
    {name: '李禄俊', busy: false},
    {name: '何珂俊', busy: true, patient: '王筑艺'},
    {name: '刘可然', busy: true, patient: '戴杰'},
    {name: '石文博', busy: false},
  ]

  TREATS = [
    {name: '周韦康', busy: false},
    {name: '汪哲楠', busy: true, patient: '邢豫盛'},
    {name: '柳智宇', busy: true, patient: '金文超'},
    {name: '张子立', busy: false},
    {name: '张小楠', busy: false},
    {name: '陈祖维', busy: false},
    {name: '徐劼', busy: false},
    {name: '蒋扬', busy: true, patient: '田宇'},
  ]
end