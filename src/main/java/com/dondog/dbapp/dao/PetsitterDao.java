package com.dondog.dbapp.dao;

import java.util.List;
import java.util.Map;

import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.dto.PetDto;
import com.dondog.dbapp.dto.PetsitterFormDto;
import com.dondog.dbapp.dto.PetsitterQ_cancel;
import com.dondog.dbapp.dto.PetsitterQuestion;
import com.dondog.dbapp.dto.PetsitterQuestlistDto;
import com.dondog.dbapp.dto.ResPetsitterDto;
import com.dondog.dbapp.dto.petsitter_listDto;
import com.dondog.dbapp.dto.quest_listDto;

public interface PetsitterDao {
	
	//비밀번호 구하기
	public String getEncPwd(String id);
	
	public boolean petsitter_quest_Insert(ResPetsitterDto respet);
	
	public List<PetDto> getPetInfo(String id);
	
	public List<PetsitterQuestion> getpet_question();
	
	public boolean PetsitterForm_Insert(PetsitterFormDto petsitterForm);
	
	public List<petsitter_listDto> getsitterList(int num);
	
	public MemberDto getsitterContents(String snum);
	
	public PetsitterFormDto getpetForm(String mid);
	
	public int getsitterListCnt();
	
	public int getquestListCnt();
	
	public List<quest_listDto> getquestList(int num);
	
	public ResPetsitterDto getquestContents(String pnum);
	
	public MemberDto getMemberInfo_res(String mid);
	
	public PetDto getpetInfo_res(String pid);
	
	public boolean PetsitterRes_update(ResPetsitterDto updateres);
	
	
	public List<ResPetsitterDto> getingList(String mid);
	
	public MemberDto getpstInfo_res(String pst_pstid);
	
	public boolean PetsitterRes_updatelast(ResPetsitterDto updatereslast);
	
	public boolean PetsitterRes_updatecancle(ResPetsitterDto updatereslast);
	public boolean PetsitterRes_questcancle(ResPetsitterDto updatereslast);
	
	
	public List<quest_listDto> getquestListsuc(int num);
	
	public boolean Petsitter_questList(PetsitterQuestlistDto psq);
	public ResPetsitterDto Petsitter_ressurch(String rsp_num);
	
	public List<PetsitterQuestlistDto> getquestList2(String mid);
	
	public PetsitterQuestlistDto getmyquestContents(String mnum);
	
	public List<PetsitterQuestlistDto> getyouquestList2(String mid);
	
	//펫시터 의뢰 완료시 증가될값
	public boolean getmp_eat_up(String mp_num);
	public boolean getmp_walk_up(String mp_num);
	public boolean getmp_bath_up(String mp_num);
	public boolean getmp_medic_up(String mp_num);
	public boolean getmp_clean_up(String mp_num);
	
	//
	public boolean Petsitter_questList_cancle(PetsitterQ_cancel pq_cancel);
	
	//의뢰완료 업데이트
	public boolean petsittersucess(String mp_num);
	public boolean mysucess(String mp_num);
	//의뢰완료 사항 확인하기
	public Integer petsittersucess_chk(String mp_num);
	public Integer mysucess_chk(String mp_num);
	
	public boolean questcomp(String mp_num);
	
	public boolean res_comp(String rsp_num);
	
	public List<ResPetsitterDto> pst_res_list(String mid);
	
	public List<ResPetsitterDto> pst_come_list(String mid);
	
	public boolean res_update(ResPetsitterDto resDto);
	
}




