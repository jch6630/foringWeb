package kr.co.foring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/foring")
@Log4j
public class ForingController {

	@RequestMapping("/main")
	public void basic() {
		log.info("foring Web Start....................");
	}
//
//	@RequestMapping(value = "/basic", method = { RequestMethod.GET, RequestMethod.POST })
//	public void basicGet() {
//		Logger.info("basicGet1...........");
//		log.info("basicGet2...........");
//	}
//
//	@RequestMapping(value = "/basic1", method = RequestMethod.POST)
//	public void basicPost() {
//		Logger.info("basicPost3...........");
//		log.info("basicPost4...........");
//
//	}
//
//	@RequestMapping(value = "/basic1", method = RequestMethod.GET)
//	public void basicGet2() {
//		Logger.info("basicGet7...........");
//		log.info("basicGet8...........");
//
//	}
//
//	@GetMapping("/basicOnlyGet")
//	public void basicGet3() {
//		Logger.info("basic get only Get5...........");
//		log.info("basic  get only Get6...........");
//	}
//
//	@PostMapping("/basicOnlyGet")
//	public void basicPost2() {
//		Logger.info("basic get only Post5...........");
//		log.info("basic  get only Post6...........");
//	}
//
//	@GetMapping("/ex01")
//	public String ex01(SampleDTO sDto, Model model) {
//		log.info("log ====> " + sDto);
//		Logger.info("logger ====> " + sDto);
//
//		model.addAttribute("exDto", sDto);
//		return "ex01";
//	}
//
//	@GetMapping("/ex02")
//	public String ex02(@RequestParam("name") String superName, @RequestParam("age") int superAge) {
//		log.info("superName : " + superName);
//		log.info("superName : " + superAge);
//		return "ex02";
//	}
//
//	@GetMapping("/ex02List")
//	public String ex02List(@RequestParam("ids") ArrayList<String> ids) {
//		log.info("ids : " + ids);
//		return "ex02List";
//	}
//	
//	@GetMapping("/ex02Array")
//	public String ex02Array(@RequestParam("ids") String[] ids) {
//		log.info("Array ids : " + Arrays.toString(ids));
//		return "ex02Array";
//	}
//	
//	@GetMapping("/ex02Bean")
//	public String ex02Bean(SampleDTOList list) {
//		log.info("list dtos : " + list);
//		return "ex02Bean";
//	}
//	
////	@InitBinder
////	public void initBinder(WebDataBinder binder) {
////		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
////		binder.registerCustomEditor(java.util.Date.class,
////		new CustomDateEditor(dateFormat, false));
////	}
//	
//	@GetMapping("/ex03")
//	public String ex03(TodoDTO todo) {
//		log.info("todo : " + todo);
//		return "ex03";
//	}
//	
//	@RequestMapping("/sampleModel")
//	public String sampleModel(Model model) {
//		SampleDTO sampleDTO = new SampleDTO("홍길동", 10);
//		log.info("sampleModel");
//		
//		model.addAttribute("sampleDto", sampleDTO);
//		model.addAttribute("name", sampleDTO.getName());
//		model.addAttribute("age", sampleDTO.getAge());
//		return "/sample/sample";
//	}
//	
//	@GetMapping("/ex04")
//	public String ex04(SampleDTO sDto, @ModelAttribute("page") int page) {
//		log.info("sDto : " + sDto);
//		log.info("page : " + page);
//		
//		return "/sample/ex04";
//	}
//	
//	@RequestMapping("/doE")
//	public String doE(RedirectAttributes rttr) {
//		log.info("doE 호출되지만 /doF로 리다이렉트..........");
//		rttr.addFlashAttribute("msg", "리다이렉트된 메세지 입니다.");
//		return "redirect:/sample/doF";
//	}
//	
//	@RequestMapping("/doF")
//	public String doF() {
//		log.info("doF 호출 됨...........");
//		return "/sample/redirectAttributeResult";
//	}
//	@RequestMapping("/ex05")
//	public void ex05() {
//		log.info("ex05..........");
//	}
//	
//	@RequestMapping("/ex06")
//	@ResponseBody
//	public SampleDTO ex06() {
//		log.info("/ex06.........");
//		
//		SampleDTO dto = new SampleDTO();
//		dto.setName("홍길동");
//		dto.setAge(30);
//		
//		return dto;
//	}
//	
//	@RequestMapping("/ex06_1")
//	public @ResponseBody Map<String, List<SampleDTO>> ex06_1(){
//		log.info("/ex06_1...............");
//		
//		List<SampleDTO> list = new ArrayList<SampleDTO>();
//		SampleDTO dto01 =new SampleDTO();
//		dto01.setName("홍길동");
//		dto01.setAge(30);
//		list.add(dto01);
//
//		SampleDTO dto02 =new SampleDTO();
//		dto02.setName("홍길동");
//		dto02.setAge(30);
//		list.add(dto02);
//		
//		Map<String, List<SampleDTO>> map = new HashMap<>();
//		map.put("info", list);
//		
//		return map;
//	}
//	
//	@RequestMapping("/ex07")
//	public ResponseEntity<String> ex07(){
//		log.info("/ex07.............");
//		String msg ="{\"name\":\"홍길동\"}";
//		
//		HttpHeaders header = new HttpHeaders();
//		header.add("Content-type", "application/json;charset=UTF-8");
//		
//		return new ResponseEntity<>(msg, header, HttpStatus.OK);
//	}
//	
//	@RequestMapping(value = "/exFileUpload", method=RequestMethod.GET)
//	public void exFileUpload() {
//		log.info("/exFileUpload...........");
//	}
//	
//	@RequestMapping(value = "/exUploadPost", method=RequestMethod.POST)
//	public void exUploadPost(ArrayList<MultipartFile> files) throws Exception {
//		log.info("/exUploadPost..............");
//		
//		files.forEach(file -> {
//			log.info("-----------------------------------");
//			log.info("fileName : " + file.getOriginalFilename());
//			log.info("fileSize : " + file.getSize());
//		});
//	}
}
